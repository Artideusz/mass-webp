#!/bin/bash

function print_usage() {
    echo "Usage: $0 <directory with images to convert to WebP>";
}

if [ -d $1 ] ; then
    files=()
    while IFS= read -r -d $'\0'; do
        files+=("$REPLY")
    done < <(find $1 \( -iname \*.jpg -o -iname \*.png -o -iname \*.jpeg \) -print0)
    
    for i in "${files[@]}"
    do
        FILE="${i}.webp"
        if [ -f "${FILE}" ] ; then
            echo "${FILE} already exists. Skipping..."
        else
            echo "${FILE} does not exist! Creating a webp image!"
            cwebp "$i" -o "$FILE" > /dev/null 2>&1
        fi
    done
else
    print_usage
    exit 1
fi
