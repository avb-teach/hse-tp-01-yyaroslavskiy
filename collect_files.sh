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

input=""
output=""
depth=""

while [[ $# -gt 0 ]]; do
    case "$1" in
	--max_depth)
	    depth="$2"
	    shift 2
	    ;;
	*)
	    if [[ -z "$input" ]]; then
		input="$1"
	    else
		output="$1"
	    fi
	    shift
	    ;;
    esac
done

if [ -n "$depth" ]; then
    find "$input" -maxdepth "$depth" -type f -print0 | while read -r -d '' object; do
    	copy "$object" "$output"
    done
else
    find "$input" -type f -print0 | while read r -d '' object; do
    	copy "$object" "$output"
    done
fi
