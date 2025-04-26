#!/bin/bash
if [ -z "$3" ]; then
    find "$1" -type f -exec cp {} "$2" \;
else
    find "$1" -maxdepth "$3" -type f -exec cp {} "$2" \;
fi

