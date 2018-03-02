## Przygotowanie punktów adresowych z terenu Polski w formacie JSON (CSV?)

Użyte narzędzia: _jq_ 1.5, _gdal_ 2.2,
[instalacja](https://tilemill-project.github.io/tilemill/docs/guides/gdal/).

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

Błędy w trakcie zmiany formatu plików dla każdego województwa:
dolnośląskiego, kujawsko-pomorskiego, lubelskiego, lubuskiego, łódzkiego,
małopolskiego, opolskiego, podkarpackiego, podlaskiego, pomorskiego, śląskiego,
warmińsko-mazurskiego, wielkopolskiego i zachodnioporskiego:
```
Przetwarzanie ogr2ogr: pktadr/2018_02_26_08_16_11__02_dolnośląskie.xml
Warning 6: dataset temp/2018_02_26_08_16_11__02_dolnośląskie.xml.geojson does not support layer creation option ENCODING
ERROR 1: Layer 'PRG_JednostkaAdministracyjnaNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
ERROR 1: Layer 'PRG_MiejscowoscNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
ERROR 1: Layer 'PRG_UlicaNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
Przetwarzanie jq: pktadr/2018_02_26_08_16_11__02_dolnośląskie.xml
Przetwarzanie ogr2ogr: pktadr/2018_02_26_08_16_11__04_kujawsko-pomorskie.xml
Warning 6: dataset temp/2018_02_26_08_16_11__04_kujawsko-pomorskie.xml.geojson does not support layer creation option ENCODING
ERROR 1: Layer 'PRG_JednostkaAdministracyjnaNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
ERROR 1: Layer 'PRG_MiejscowoscNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
ERROR 1: Layer 'PRG_UlicaNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
Przetwarzanie jq: pktadr/2018_02_26_08_16_11__04_kujawsko-pomorskie.xml
Przetwarzanie ogr2ogr: pktadr/2018_02_26_08_16_11__06_lubelskie.xml
Warning 6: dataset temp/2018_02_26_08_16_11__06_lubelskie.xml.geojson does not support layer creation option ENCODING
ERROR 1: Layer 'PRG_JednostkaAdministracyjnaNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
ERROR 1: Layer 'PRG_MiejscowoscNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
ERROR 1: Layer 'PRG_UlicaNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
Przetwarzanie jq: pktadr/2018_02_26_08_16_11__06_lubelskie.xml
Przetwarzanie ogr2ogr: pktadr/2018_02_26_08_16_11__08_lubuskie.xml
Warning 6: dataset temp/2018_02_26_08_16_11__08_lubuskie.xml.geojson does not support layer creation option ENCODING
ERROR 1: Layer 'PRG_JednostkaAdministracyjnaNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
ERROR 1: Layer 'PRG_MiejscowoscNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
ERROR 1: Layer 'PRG_UlicaNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
Przetwarzanie jq: pktadr/2018_02_26_08_16_11__08_lubuskie.xml
Przetwarzanie ogr2ogr: pktadr/2018_02_26_08_16_11__10_łódzkie.xml
Warning 6: dataset temp/2018_02_26_08_16_11__10_łódzkie.xml.geojson does not support layer creation option ENCODING
ERROR 1: Layer 'PRG_JednostkaAdministracyjnaNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
ERROR 1: Layer 'PRG_MiejscowoscNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
ERROR 1: Layer 'PRG_UlicaNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
Przetwarzanie jq: pktadr/2018_02_26_08_16_11__10_łódzkie.xml
Przetwarzanie ogr2ogr: pktadr/2018_02_26_08_16_11__12_małopolskie.xml
Warning 6: dataset temp/2018_02_26_08_16_11__12_małopolskie.xml.geojson does not support layer creation option ENCODING
ERROR 1: Layer 'PRG_JednostkaAdministracyjnaNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
ERROR 1: Layer 'PRG_MiejscowoscNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
ERROR 1: Layer 'PRG_UlicaNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
Przetwarzanie jq: pktadr/2018_02_26_08_16_11__12_małopolskie.xml
Przetwarzanie ogr2ogr: pktadr/2018_02_26_08_16_11__14_mazowieckie.xml
Warning 6: dataset temp/2018_02_26_08_16_11__14_mazowieckie.xml.geojson does not support layer creation option ENCODING
ERROR 1: Layer 'PRG_JednostkaAdministracyjnaNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
ERROR 1: Layer 'PRG_MiejscowoscNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
ERROR 1: Layer 'PRG_UlicaNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
Przetwarzanie jq: pktadr/2018_02_26_08_16_11__14_mazowieckie.xml
Przetwarzanie ogr2ogr: pktadr/2018_02_26_08_16_11__16_opolskie.xml
Warning 6: dataset temp/2018_02_26_08_16_11__16_opolskie.xml.geojson does not support layer creation option ENCODING
ERROR 1: Layer 'PRG_JednostkaAdministracyjnaNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
ERROR 1: Layer 'PRG_MiejscowoscNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
ERROR 1: Layer 'PRG_UlicaNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
Przetwarzanie jq: pktadr/2018_02_26_08_16_11__16_opolskie.xml
Przetwarzanie ogr2ogr: pktadr/2018_02_26_08_16_11__18_podkarpackie.xml
Warning 6: dataset temp/2018_02_26_08_16_11__18_podkarpackie.xml.geojson does not support layer creation option ENCODING
ERROR 1: Layer 'PRG_JednostkaAdministracyjnaNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
ERROR 1: Layer 'PRG_MiejscowoscNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
ERROR 1: Layer 'PRG_UlicaNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
Przetwarzanie jq: pktadr/2018_02_26_08_16_11__18_podkarpackie.xml
Przetwarzanie ogr2ogr: pktadr/2018_02_26_08_16_11__20_podlaskie.xml
Warning 6: dataset temp/2018_02_26_08_16_11__20_podlaskie.xml.geojson does not support layer creation option ENCODING
ERROR 1: Layer 'PRG_JednostkaAdministracyjnaNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
ERROR 1: Layer 'PRG_MiejscowoscNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
ERROR 1: Layer 'PRG_UlicaNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
Przetwarzanie jq: pktadr/2018_02_26_08_16_11__20_podlaskie.xml
Przetwarzanie ogr2ogr: pktadr/2018_02_26_08_16_11__22_pomorskie.xml
Warning 6: dataset temp/2018_02_26_08_16_11__22_pomorskie.xml.geojson does not support layer creation option ENCODING
ERROR 1: Layer 'PRG_JednostkaAdministracyjnaNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
ERROR 1: Layer 'PRG_MiejscowoscNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
ERROR 1: Layer 'PRG_UlicaNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
Przetwarzanie jq: pktadr/2018_02_26_08_16_11__22_pomorskie.xml
Przetwarzanie ogr2ogr: pktadr/2018_02_26_08_16_11__24_śląskie.xml
Warning 6: dataset temp/2018_02_26_08_16_11__24_śląskie.xml.geojson does not support layer creation option ENCODING
ERROR 1: Layer 'PRG_JednostkaAdministracyjnaNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
ERROR 1: Layer 'PRG_MiejscowoscNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
ERROR 1: Layer 'PRG_UlicaNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
Przetwarzanie jq: pktadr/2018_02_26_08_16_11__24_śląskie.xml
Przetwarzanie ogr2ogr: pktadr/2018_02_26_08_16_11__26_świętokrzyskie.xml
Warning 6: dataset temp/2018_02_26_08_16_11__26_świętokrzyskie.xml.geojson does not support layer creation option ENCODING
ERROR 1: Layer 'PRG_JednostkaAdministracyjnaNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
ERROR 1: Layer 'PRG_MiejscowoscNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
ERROR 1: Layer 'PRG_UlicaNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
Przetwarzanie jq: pktadr/2018_02_26_08_16_11__26_świętokrzyskie.xml
Przetwarzanie ogr2ogr: pktadr/2018_02_26_08_16_11__28_warmińsko-mazurskie.xml
Warning 6: dataset temp/2018_02_26_08_16_11__28_warmińsko-mazurskie.xml.geojson does not support layer creation option ENCODING
ERROR 1: Layer 'PRG_JednostkaAdministracyjnaNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
ERROR 1: Layer 'PRG_MiejscowoscNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
ERROR 1: Layer 'PRG_UlicaNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
Przetwarzanie jq: pktadr/2018_02_26_08_16_11__28_warmińsko-mazurskie.xml
Przetwarzanie ogr2ogr: pktadr/2018_02_26_08_16_11__30_wielkopolskie.xml
Warning 6: dataset temp/2018_02_26_08_16_11__30_wielkopolskie.xml.geojson does not support layer creation option ENCODING
ERROR 1: Layer 'PRG_JednostkaAdministracyjnaNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
ERROR 1: Layer 'PRG_MiejscowoscNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
ERROR 1: Layer 'PRG_UlicaNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
Przetwarzanie jq: pktadr/2018_02_26_08_16_11__30_wielkopolskie.xml
Przetwarzanie ogr2ogr: pktadr/2018_02_26_08_16_11__32_zachodniopomorskie.xml
Warning 6: dataset temp/2018_02_26_08_16_11__32_zachodniopomorskie.xml.geojson does not support layer creation option ENCODING
ERROR 1: Layer 'PRG_JednostkaAdministracyjnaNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
ERROR 1: Layer 'PRG_MiejscowoscNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
ERROR 1: Layer 'PRG_UlicaNazwa' does not already exist in the output dataset, and cannot be created by the output driver.
Przetwarzanie jq: pktadr/2018_02_26_08_16_11__32_zachodniopomorskie.xml
```

<!--
### Pliki GeoJSON gotowe do załadowania do MongoDB

* [Punkty adresowe](https://drive.google.com/file/d/1c76CsnoARrlPwRoOsInwhvXnYVPWgiZx/view?usp=sharing) w formacie geojson(bez nagłówka) z dnia 19.02.2018
-->

### 3. Clean up data with Trifacta Wrangler

* [Introduction to Data Wrangling](https://community.trifacta.com/s/online-training)


### 4. Zapisz dane z plików do bazy MongoDB (standalone)

Pliki powinny znajdować się w katalogu _geojson_.

```bash
../bin/03_zaladujDane.sh
```

## Uwagi

1. Program _jq_ w wersji dla systemu Windows generuje plik JSON z dodatkową
linią na końcu, co przy późniejszym imporcie programem _mongoimport_ powoduje
błąd po wczytaniu wszystkich danych.

1. Przed wczytaniem do bazy danych nie należy łączyć w jeden plik plików
przetworzonych przez program _jq_ na systemie Windows.
Należy wczytywać pliki pojedynczo.
