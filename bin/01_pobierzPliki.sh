#! /bin/bash

curl ftp://91.223.135.109/prg/punkty_adresowe.zip -o temp.zip
unzip temp.zip -d pktadr
rm temp.zip
