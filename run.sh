#!/bin/bash
set -e

if ! command -v scanimage &>/dev/null; then
    echo "error: scanimage not found" >&2
    exit 1
fi

SCANDIR=$(mktemp -d)
OUTPUTDIR=$(pwd)
BASENAME=$(date +%Y%m%d%H%M%S)

cd "$SCANDIR"

scanimage -b --format png  -d 'fujitsu:ScanSnap iX500:343632' --source 'ADF Duplex' --resolution 300

if [[ "$1" == "--pdf" ]]; then
    OUTPUT="$BASENAME.pdf"
    echo "outputting to $OUTPUTDIR/$OUTPUT"
    magick ./*.png "$OUTPUTDIR"/"$OUTPUT"
else
    echo "outputting PNGs to $OUTPUTDIR/"
    mv ./*.png "$OUTPUTDIR"/
fi
