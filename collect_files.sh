#!/bin/bash

copy(){
    local name=$(basename "$1")
    local i=1
    local file_route="$2/$name"
    while [[ -e "$file_route" ]] do
        file_route="$2/${name}.$i"
        let i++
    done
    cp -p "$1" "$file_route"
}

if [ -z "$3" ]; then
    find "$1" -type f | while read -r -d '' object; do
    copy "$object" "$2"
    done
else
    find "$1" -maxdepth "$3" -type f | while read -r -d '' object; do
    copy "$object" "$2"
    done
fi
