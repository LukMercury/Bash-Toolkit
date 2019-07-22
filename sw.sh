#!/bin/bash

# Switch two files if they exist

if [ -f "$1" ] && [ -f "$2" ]; then
    cp "$1" temp
    mv "$2" "$1"
    mv temp "$2"
fi
