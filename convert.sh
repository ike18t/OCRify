#!/bin/bash

if [ -d "/mnt/nas/scans" ]; then
  echo "Checking for new scans"
  for filepath in /mnt/nas/scans/[^.]*.tif; do
    echo "Found scan ${filepath}"
    [ -e "$filepath" ] || continue
    MONTH=$(date '+%m')
    DAY=$(date '+%d')
    YEAR=$(date '+%Y')
    DIRECTORY="/mnt/nas/docs/$YEAR/$MONTH"
    mkdir -p $DIRECTORY
    GUID="$(tr -dc 'a-f0-9' < /dev/urandom | head -c10)"
    FILENAME="${MONTH}${DAY}${YEAR}_${GUID}"
    OUTFILE="${DIRECTORY}/${FILENAME}"
    echo "Converting ${filepath} to ${OUTFILE}"
    tesseract $filepath $OUTFILE pdf
    if [ -f "${OUTFILE}.pdf" ]; then
      rm $filepath
    fi
  done
fi
