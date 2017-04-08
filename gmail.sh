#!/bin/bash

FILEPATH=$(ls gmail/optional/apkbin/app/PrebuiltGmail/com.*.apk)
FILENAME=PrebuiltGmail.apk
INDIR=gmail
NAME=gapps-gmail
VER=arm-arm64-klmn

DATE=$(date +%F-%H-%M)
BASEDIR=$(pwd)

echo "" >> build.log
echo "Updating "$INDIR" on $DATE" >> build.log
echo "Google Gmail add-on for 4.4.4+ (arm/arm64) (replaces stock email client)" >> build.log

DIR=$(dirname "${FILEPATH}")
FILE=${FILEPATH##*/}
NOEXT=${FILE%\.*}

cd "$DIR"

if ! [ $FILE == "" ]; then
  rm "$FILENAME"
  mv "$FILE" "$FILENAME"
fi

VERSION=$(echo "$FILE" | cut -d "_" -f 2)
APIVER=$(echo "$FILE" | cut -d "_" -f 3)

cd "$BASEDIR"

echo "Version: $VERSION" >> build.log
echo "API: $APIVER" >> build.log
echo "" >> build.log

./makezipsign.sh "$INDIR" "$NAME" "$VER"
