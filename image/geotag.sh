#!/bin/bash

# Add Geolocation to JPEG images and keeps modification time

# Usage
if ! command -v exiftool &> /dev/null
then
    echo "exiftool not installed."
    exit 1
fi

# Usage
if [ $# -lt 1 ]; then
    echo "Uso: $0 <IMAGE_FILE> [latitude] [longitude]"
    exit 1
fi

IMAGE_FILE=$1

# Coordinates (Default if not declared)
LATITUDE=${2:-"-13.5160789"}
LONGITUDE=${3:-"-71.9779785"}


FILE_DATE=$(stat -c %y "$IMAGE_FILE" | cut -d '.'  -f 1)
exiftool -GPSLatitude="$LATITUDE" -GPSLatitudeRef="$LATITUDE" -GPSLongitude="$LONGITUDE" -GPSLongitudeRef="$LONGITUDE" "$IMAGE_FILE"

if [ $? -eq 0 ]; then
    echo "Geotag appended successfully in $IMAGE_FILE."
else
    echo "Geotag failed for $IMAGE_FILE."
    exit 1
fi

touch -d "$FILE_DATE" "$IMAGE_FILE"

#mkdir tmp
mv "${IMAGE_FILE}_original" tmp/ 
