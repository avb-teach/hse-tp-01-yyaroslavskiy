#!/bin/bash

copy(){
    local name=$(basename "$1")
    local i=1
    local file_route="$2/$name"
    while [[ -e "$file_route" ]]; do
        file_route="$2/${name}.$i"
        ((i++))
    done
    cp -p "$1" "$file_route"
}

input="$1"
output="$2"
depth="$4"

if [ -n "$depth" ]; then
    find "$input" -maxdepth "$depth" -type f -print0 | while read -r -d '' object; do
    	copy "$object" "$output"
    done
else
    find "$input" -type f -print0 | while read r -d '' object; do
    	copy "$object" "$output"
    done
fi
