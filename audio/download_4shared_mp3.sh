#!/bin/bash
#Gets a 4Shared mp3 preview and download it
#Usage: $1 url

URL=$1
URL=$(curl --silent ${URL} | grep preview.mp3  | awk '{print $4}' | cut -f 2 -d "="  | sed 's/\"//g' ; )

wget ${URL}