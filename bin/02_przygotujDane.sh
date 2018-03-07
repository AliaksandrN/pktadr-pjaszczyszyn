#! /bin/bash

folder_pktadr="pktadr"
folder_temp="temp"
folder_json="json"
numer_pliku=0

mkdir -p $folder_temp
mkdir -p $folder_json
rm -f $folder_temp/*
rm -f $folder_json/*

shopt -s nullglob

pliki=($folder_pktadr/*.xml)
# printf '%s\n' "${pliki[@]}"

for plikxml in "${pliki[@]}"
do
  printf 'Przetwarzanie ogr2ogr: %s\n' "$plikxml"
  plikjson=$(basename $plikxml .xml).json
  ogr2ogr -skipfailures -s_srs EPSG:2180 -t_srs EPSG:4326 -lco ENCODING=UTF-8 \
    -f "GeoJSON" -sql "select * from PRG_PunktAdresowy" \
    $folder_temp/$plikjson $plikxml
  printf 'Przetwarzanie jq: %s\n' "$plikjson"
  # jq --compact-output ".features[]" $folder_temp/$plikjson $folder_json/$plikjson
  jq --compact-output ".features[]" $folder_temp/$plikjson \
  | gzip --stdout > $folder_json/$plikjson.gz
  rm $folder_temp/$plikjson
  # numer_pliku=$(($numer_pliku + 1))
  (( numer_pliku++ ))

done

#printf 'Kompresowanie plików w folderze %s\n' "$plikxml"
#gzip $folder_json/*.json

echo "----"
echo "Przetworzono plików: $numer_pliku"


rmdir $folder_temp
