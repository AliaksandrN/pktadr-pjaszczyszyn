#!/bin/bash
nazwaBazy="test"
nazwaKolekcji="pktadr"
folderGeojson="geojson"

shopt -s nullglob
pliki=($folderGeojson/*.geojson)
#printf '%s\n' "${pliki[@]}"

for plik in "${pliki[@]}"
do
    printf 'Ładowanie pliku: %s\n' "$plik"
    mongoimport --db $nazwaBazy --collection $nazwaKolekcji --jsonArray --file $plik
done
