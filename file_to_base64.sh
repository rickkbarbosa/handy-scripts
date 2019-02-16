#!/bin/bash

FILE=$1
OUTPUT=$2

#Convert a file on base64-text
cat $1 | base64 -w0 > $OUTPUT