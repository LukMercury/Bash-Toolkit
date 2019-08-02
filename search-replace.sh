#!/bin/bash

# Recursive search and replace string1 with string2
# Usage: search-replace <string1> <string2> <path>
# Use with caution!

COUNTER=0

for i in $(grep -R "$1" "$3" | cut -d: -f1 | uniq); do
    sed -i "s/$1/$2/g" "$i"
    echo "$i"
    ((COUNTER++))
done

echo "$COUNTER files modified"

