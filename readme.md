# Projekt: przygotowanie punktów adresowych z terenu Polski dla bazy MongoDB

## Zależności:
- gdal 1.11
- jq
- mongoDB

## Instalacja gdal
* [Instrukcja](https://tilemill-project.github.io/tilemill/docs/guides/gdal/)

# Obróbka danych
## 1. Pobierz plik i rozpakuj do folderu `pktadr`
```bash
$ curl ftp://91.223.135.109/prg/punkty_adresowe.zip -o pktadr.zip
$ unzip punkty_adresowe.zip -d pktadr
$ rm punkty_adresowe.zip
```
### Uwaga: nazwy plików w paczce mogą mieć niestandardowe znaki, więc w razie błędów należy je rozpakować odpowiednim narzędziem

## 2. Uruchom skrypt do przygotowania plików geoJson
```bash
$ ./02_przygotujDane.sh
```
### Pliki geojson gotowe do załadowania do mongoDB
* [Punkty adresowe](https://drive.google.com/file/d/1c76CsnoARrlPwRoOsInwhvXnYVPWgiZx/view?usp=sharing) w formacie geojson(bez nagłówka) z dnia 19.02.2018

## 3. Załaduj pliki do bazy mongoDB
Pliki powinny znajdować się w katalogu `geojson`
```bash
$ ./03_zaladujDane.sh
```

## Uwagi
jq w wersji dla windows generuje plik json z dodatkową linią na końcu, co przy imporcie w mongoimport powoduje błąd podczas ładowania, ale już po załadowaniu wszystkich danych. Nie należy łączyć plików wygenerowanych przez jq na windowsie w jeden plik przed załadowaniem do bazy, należy załadować pliki pojedynczo