#!/bin/bash

# Switch two files if they exist

if [ -f "$1" ] && [ -f "$2" ]; then
    TEMP_DIR="_sw_temp_dir"
    mkdir "$TEMP_DIR"
    mv -n "$1" "$TEMP_DIR"
    mv -n "$2" "$1"
    mv -n "$TEMP_DIR/$1" "./$2"
    rmdir "$TEMP_DIR"
fi
