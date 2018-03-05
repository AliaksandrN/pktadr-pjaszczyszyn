#! /bin/bash

nazwaBazy="test"
nazwaKolekcji="pktadr"
folderGeojson="geojson"

shopt -s nullglob

pliki=($folderGeojson/*.json.gz)

for plik in "${pliki[@]}"
do
    printf 'Import danych z pliku: %s\n' "$plik"
    gunzip -c $plik \
    | mongoimport --db=$nazwaBazy --collection=$nazwaKolekcji
done
