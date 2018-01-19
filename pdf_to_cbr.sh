#!/bin/bash

FILES=$1

mkdir /tmp/tmp
cp ${FILES} /tmp/tmp

cd /tmp/tmp
#convert ${FILE} %03d.png

for FILE in $FILES; do 
	echo "exploding file ${FILE}.pdf ..."; 
	#convert ${FILE} %03d.png; 
	pdftoppm -png ${FILE} $(basename ${FILE} .pdf;);
	echo "converting png file on cbr"; 
	zip ${FILE}.cbr *.png; 
	echo "removing png files"; 
	rm *.png; 
done
