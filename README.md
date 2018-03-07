## Przygotowanie punktów adresowych z terenu Polski w formacie JSON (CSV?)

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

**Uwaga:** _jq_ powinien wybrać listę JSON–ów.
```bash
../bin/02_przygotujDane.sh
```

<!--
### Pliki GeoJSON gotowe do załadowania do MongoDB

* [Punkty adresowe](https://drive.google.com/file/d/1c76CsnoARrlPwRoOsInwhvXnYVPWgiZx/view?usp=sharing) w formacie geojson(bez nagłówka) z dnia 19.02.2018
-->

### 3. Clean up data with Trifacta Wrangler

* [Introduction to Data Wrangling](https://community.trifacta.com/s/online-training)

### 4. Zapisz dane z plików do bazy MongoDB (standalone)

Pliki zawierające JSON-y, jeden JSON w jednym wierszu, powinny znajdować
się w katalogu _json_: 16 plików, razem 5,119,432,324 bajtów.
Spakowane programem _gzip_ pliki zajmują 579,741,734 bajtów.
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

Przykładowy dokument z kolekcji _malopolskie_:
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
