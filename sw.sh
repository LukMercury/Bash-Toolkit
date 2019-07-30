#!/bin/bash

# Switch two files if they exist

if [ -f "$1" ] && [ -f "$2" ]; then
    mkdir "${1}_${2}_sw_temp_dir"
    cp "$1" "${1}_${2}_sw_temp_dir"
    mv "$2" "$1"
    mv "${1}_${2}_sw_temp_dir/$1" "./$2"
    rmdir "${1}_${2}_sw_temp_dir"
fi
