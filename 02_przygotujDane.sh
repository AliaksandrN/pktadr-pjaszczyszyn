#!/bin/bash
folderPktAdr="pktadr"
folderTymczasowy="temp"
folderGeojson="geojson"
numerPliku=0
mkdir $folderTymczasowy
mkdir $folderGeojson
rm $folderTymczasowy/*
rm $folderGeojson/*

shopt -s nullglob
pliki=($folderPktAdr/*.xml)
#printf '%s\n' "${pliki[@]}"

for plikxml in "${pliki[@]}"
do
    printf 'Przetwarzanie ogr2ogr: %s\n' "$plikxml"
    ogr2ogr -s_srs EPSG:2180 -t_srs EPSG:4326 -lco ENCODING=UTF-8 -f "GeoJSON" -clipsrclayer "PRG_PunktAdresowy" $folderTymczasowy/$numerPliku.geojson $plikxml -skipfailures
    printf 'Przetwarzanie jq: %s\n' "$plikxml"
    jq --compact-output ".features" $folderTymczasowy/$numerPliku.geojson > $folderGeojson/$numerPliku.mongodb.geojson
    rm $folderTymczasowy/$numerPliku.geojson
    numerPliku=$(($numerPliku + 1))
done

rmdir $folderTymczasowy