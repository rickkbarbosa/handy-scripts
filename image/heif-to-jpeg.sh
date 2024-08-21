#!/bin/bash

# Convert all HEIC files (default iPhone image format) to JPEG
# Must have libheif installed 

for FILE in $(ls *.HEIC); do 
    FILE_DATE=$(stat -c %y "${FILE}" | cut -d '.'  -f 1)
    heif-convert ${FILE} "$(basename ${FILE} .HEIC;).jpg";
    touch -d "$FILE_DATE" "$(basename ${FILE} .HEIC;).jpg"
done