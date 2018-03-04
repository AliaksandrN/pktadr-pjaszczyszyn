#! /bin/bash

folderPktAdr="pktadr"
folderTymczasowy="temp"
folder_json="json"
numerPliku=0
mkdir -p $folderTymczasowy
mkdir -p $folder_json
rm -f $folderTymczasowy/*
rm -f $folder_json/*

shopt -s nullglob

pliki=($folderPktAdr/*.xml)
# printf '%s\n' "${pliki[@]}"

for plikxml in "${pliki[@]}"
do
  printf 'Przetwarzanie ogr2ogr: %s\n' "$plikxml"
  plikjson=$(basename $plikxml .xml).json
  ogr2ogr -s_srs EPSG:2180 -t_srs EPSG:4326 -lco ENCODING=UTF-8 -f "GeoJSON" \
    -clipsrclayer "PRG_PunktAdresowy" \
    $folderTymczasowy/$plikjson $plikxml -skipfailures
  printf 'Przetwarzanie jq: %s\n' "$plikxml"
  jq --compact-output ".features[]" $folderTymczasowy/$plikjson \
    > $folder_json/$plikjson
  rm $folderTymczasowy/$plikjson
  numerPliku=$(($numerPliku + 1))
done

gzip ($folder_json/*.json)

echo "----"
echo "Przetworzono plików: $numerPliku"

rmdir $folderTymczasowy
