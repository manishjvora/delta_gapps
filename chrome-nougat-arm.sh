#!/bin/bash

FILEPATH=$(find chrome-nougat-arm/system/app/GoogleChrome -name com.*.apk | sort)
FILENAME=GoogleChrome.apk
INDIR=chrome-nougat-arm
NAME=gapps-chrome
VER=arm-n

DATE=$(date +%F-%H-%M)
BASEDIR=$(pwd)

function tout {
  tee /dev/tty >> "$BASEDIR"/build.log
}

echo "" | tout
echo "Updating "$INDIR" on $DATE for nougat" | tout
echo "Google Chrome add-on for 7.0.0+ (arm) (replaces stock web browser) *includes Google Webview*" | tout
echo "" | tout

if [ ! "$FILEPATH" == "" ]; then

  DIR=$(dirname "${FILEPATH}")
  FILE=${FILEPATH##*/}
  NOEXT=${FILE%\.*}

  cd "$DIR"

  if [ ! "$FILE" == "" ]; then
    rm "$FILENAME"
    mv "$FILE" "$FILENAME"

    VERSION=$(echo "$FILE" | cut -d "_" -f 2)
    APIVER=$(echo "$FILE" | cut -d "_" -f 3)

    cd "$BASEDIR"
    echo "Version: $VERSION" | tout
    echo "API: $APIVER" | tout
    echo "" | tout
  fi
fi

./makezipsign.sh "$INDIR" "$NAME" "$VER"
