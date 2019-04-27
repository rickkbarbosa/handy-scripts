#!/bin/bash
# Requires ImageMagick, unzip, and unrar

COMIC_FILES="${@}"
TMPFILE=$(mktemp -d --suffix=cbrtopdf) || exit 1


for COMIC_FILE in "${COMIC_FILES}"; do
    FILENAME_BASE="${COMIC_FILE%%.*}"
    FILENAME_EXT="${COMIC_FILE#*.}"
    mkdir "${TMPFILE}/${FILENAME_BASE}"
    if [ "${FILENAME_EXT}" == "cbr" ]; then
        unrar e -idc -idp -idq "${COMIC_FILE}" "${TMPFILE}/${FILENAME_BASE}/"
    elif [ "${FILENAME_EXT}" == "cbz" ]; then
        unzip -q "${COMIC_FILE}" -d "${TMPFILE}/"
    fi
    convert "${TMPFILE}/${FILENAME_BASE}/*.jpg" "${FILENAME_BASE}.pdf"
done