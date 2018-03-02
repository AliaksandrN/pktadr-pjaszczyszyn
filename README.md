## Przygotowanie punktów adresowych z terenu Polski w formacie JSON (CSV?)

Użyte narzędzia: _jq_ 1.5, _gdal_ 1.11 (dlaczego nie użyto wersji 2.2),
[instalacja](https://tilemill-project.github.io/tilemill/docs/guides/gdal/).

Na MacOS kończymy instalację dopisując ścieżkę do programów z GDAL
do zmiennej _PATH_:
```bash
echo 'export PATH=/Library/Frameworks/GDAL.framework/Programs:$PATH' >> ~/.bash_profile
source ~/.bash_profile
```

## Data Wrangling / Obróbka danych

### 1. Pobierz plik i rozpakuj do folderu _pktadr_

Przekształacamy dane w katalogu tymczasowym.
```bash
mkdir -p tmp
cd tmp
```

Skrypt _../bin/01_pobierzPliki.sh_.
```bash
curl ftp://91.223.135.109/prg/punkty_adresowe.zip -o pktadr.zip
# 775M pktadr.zip
unzip punkty_adresowe.zip -d pktadr
ls -oh pktadr.zip
rm punkty_adresowe.zip
```

**Uwaga:** Nazwy plików w paczce mogą mieć niestandardowe znaki, więc w razie błędów należy je rozpakować odpowiednim narzędziem.

### 2. Uruchom skrypt do przygotowania plików GeoJSON

**Uwaga:** Zamiast nazwy: _0.mongodb.geojson_ powinno być _dolnośląskie.geojson_
(w kodowaniu UTF-8).

```bash
./02_przygotujDane.sh
```

Błędy w trakcie zmiany formatu plików.
3× dla każdego województwa: dolnośląskiego, kujawsko-pomorskiego, lubelskiego,
lubuskiego, łódzkiego, małopolskiego, opolskiego, podkarpackiego, podlaskiego,
pomorskiego, śląskiego, warmińsko-mazurskiego, wielkopolskiego
i zachodnioporskiego:
```
ERROR 6: GeoJSON driver doesn't support creating more than one layer
```

<!--
### Pliki GeoJSON gotowe do załadowania do MongoDB

* [Punkty adresowe](https://drive.google.com/file/d/1c76CsnoARrlPwRoOsInwhvXnYVPWgiZx/view?usp=sharing) w formacie geojson(bez nagłówka) z dnia 19.02.2018
-->

### 3. Zapisz dane z plików do bazy MongoDB (standalone)

Pliki powinny znajdować się w katalogu _geojson_.

```bash
$ ./03_zaladujDane.sh
```

## Uwagi

1. Program _jq_ w wersji dla systemu Windows generuje plik JSON z dodatkową
linią na końcu, co przy późniejszym imporcie programem _mongoimport_ powoduje
błąd po wczytaniu wszystkich danych.

1. Przed wczytaniem do bazy danych nie należy łączyć w jeden plik plików
przetworzonych przez program _jq_ na systemie Windows.
Należy wczytywać pliki pojedynczo.
