#! /bin/bash

folderPktAdr="pktadr"
folderTymczasowy="temp"
folderGeojson="geojson"
numerPliku=0
mkdir -p $folderTymczasowy
mkdir -p $folderGeojson
rm -f $folderTymczasowy/*
rm -f $folderGeojson/*

shopt -s nullglob
pliki=($folderPktAdr/*.xml)
# printf '%s\n' "${pliki[@]}"

for plikxml in "${pliki[@]}"
do
  printf 'Przetwarzanie ogr2ogr: %s\n' "$plikxml"
  plikjson=$(basename $plikxml).geojson
  ogr2ogr -s_srs EPSG:2180 -t_srs EPSG:4326 -lco ENCODING=UTF-8 -f "GeoJSON" \
    -clipsrclayer "PRG_PunktAdresowy" \
    $folderTymczasowy/$plikjson $plikxml -skipfailures
  printf 'Przetwarzanie jq: %s\n' "$plikxml"
  jq --compact-output ".features" $folderTymczasowy/$plikjson \
    > $folderGeojson/$numerPliku.geojson
  rm $folderTymczasowy/$plikjson
  numerPliku=$(($numerPliku + 1))
done

echo "----"
echo "Przetworzono plików: $numerPliku"

rmdir $folderTymczasowy
