## Przygotowanie punktów adresowych z terenu Polski w formacie JSON

Użyte narzędzia: _jq_ 1.5, _gdal_ 2.2
([instalacja](https://tilemill-project.github.io/tilemill/docs/guides/gdal/)),
gzip.

Na MacOS kończymy instalację programów z GDAL dopisując ścieżkę nich
do zmiennej _PATH_:
```bash
echo 'export PATH=/Library/Frameworks/GDAL.framework/Programs:$PATH' >> ~/.bash_profile
source ~/.bash_profile
```

## Data Wrangling / Obróbka danych

### 1. Pobierz plik i rozpakuj do folderu _pktadr_

Dane przekształcamy w katalogu tymczasowym.
```bash
mkdir -p tmp
cd tmp
```

Skrypt _../bin/01_pobierzPliki.sh_.
```bash
curl ftp://91.223.135.109/prg/punkty_adresowe.zip -o pktadr.zip
# ls -oh pktadr.zip
# 775M pktadr.zip
unzip punkty_adresowe.zip -d pktadr
rm punkty_adresowe.zip
```

**Uwaga:** Nazwy plików w paczce mogą mieć niestandardowe znaki, więc w razie błędów należy je rozpakować odpowiednim narzędziem.

### 2. Uruchom skrypt do przygotowania plików GeoJSON

```bash
../bin/02_przygotujDane.sh
```

### 3. Zapisz dane z plików do bazy MongoDB (standalone)

Pliki zawierające JSON-y, jeden JSON w jednym wierszu, powinny znajdować
się w katalogu _json_: 16 plików, razem 5,119,432,324 bajtów.
Spakowane programem _gzip_ pliki zajmują 579,741,734 bajtów.

Struktura nazwy pliku: 
```
rok_miesiąc_dzień_godzina_minuta_sekunda__NumerTerytWojewództwa_nazwaWojewództwa.json`.
```
Link do bazy [TERYT](http://eteryt.stat.gov.pl/eTeryt/rejestr_teryt/udostepnianie_danych/baza_teryt/uzytkownicy_indywidualni/przegladanie/przegladanie.aspx?contrast=default).

```bash
cd json
gunzip -c 2018_02_26_08_16_11__22_pomorskie.json.gz | \
jq --compact-output '{
  place: .properties.miejscowosc,
  street: .properties.ulica,
  zipcode: .properties.kodPocztowy,
  nr: .properties.numerPorzadkowy,
  status: .properties.status,
  geometry,
  admunit: .properties.jednostkaAdmnistracyjna
}' | \
mongoimport --drop -d test -c pomorskie
# imported 366,209 documents
```

Przykładowy dokument z kolekcji _pomorskie_:
```js
{
  "_id": ObjectId("5a99953ec709d8057650c383"),
  "place": "Borzytuchom",
  "street": "Elizy Orzeszkowej",
  "zipcode": "77-141",
  "nr": "1",
  "status": "istniejacy",
  "geometry": {
    "type": "Point",
    "coordinates": [ 17.386852875445378, 54.20146201684242 ]
  },
  "admunit": [ "Polska", "pomorskie", "bytowski", "Borzytuchom" ]
}
```

Na konsoli _mongo_ tworzymy GeoJSON _2dsphere_ index:
```bash
show collections
  pomorskie → 89.977MB / 9.785MB
count docs
  pomorskie → 366,209 document(s)

db.pomorskie.createIndex( { geometry: "2dsphere" } )
```

## Uwagi

1. Program _jq_ w wersji dla systemu Windows na standardowym wyjściu generuje plik JSON z dodatkowymi
statystykami na końcu, co przy późniejszym imporcie programem _mongoimport_ powoduje
błąd po wczytaniu wszystkich danych.

1. Przed wczytaniem do bazy danych nie należy łączyć w jeden plik plików
przetworzonych przez program _jq_ na systemie Windows.
Należy wczytywać pliki pojedynczo.
