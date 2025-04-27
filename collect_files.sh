#!/bin/bash

copy() {
    local name=$(basename "$1")
    local left="${name%.*}"
    local right="${name##*.}"
    local i=1
    local file_route="$2/$name"

    while [[ -e "$file_route" ]]; do
	if [[ "$left" == "$right" ]]; then
            file_route="$2/${left}$i"
	else
	    file_route="$2/${left}${i}.${right}"
        ((i++))
	fi
    done
 
    cp -p "$1" "$file_route"
}

if [ -z "$3" ]; then
    find "$1" -type f -print0 | while IFS= read -r -d '' object; do
        copy "$object" "$2"
    done
else
    find "$1" -maxdepth "$4" -type f -print0 | while IFS= read -r -d '' object; do
        copy "$object" "$2"
    done
fi
