#! /bin/bash

nazwaBazy="test"
nazwaKolekcji="pktadr"
folder_json="json"

shopt -s nullglob

pliki=($folder_json/*.json.gz)
# printf '%s\n' "${pliki[@]}"

mongo $nazwaBazy --eval "db.$nazwaKolekcji.drop()"

for plik in "${pliki[@]}"
do
    printf 'Import danych z pliku: %s\n' "$plik"
    
    gunzip -c $plik | \
    jq --compact-output '{
    place: .properties.miejscowosc,
    street: .properties.ulica,
    zipcode: .properties.kodPocztowy,
    nr: .properties.numerPorzadkowy,
    status: .properties.status,
    geometry,
    admunit: .properties.jednostkaAdmnistracyjna
    }' | \
    mongoimport -d $nazwaBazy -c $nazwaKolekcji
done