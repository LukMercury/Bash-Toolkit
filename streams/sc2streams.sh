#!/bin/bash

LINK=https://www.teamliquid.net/video/streams/ 

if [ -z "$1" ]; then
    MAX=20
elif [[ "$1" =~ ^[0-9]+$ ]]; then
    MAX="$1"
else
    MAX=20
fi

w3m "$LINK" | grep ^Refresh -A "$MAX" | grep "Brood War" -B "$MAX" | head -n -1 | tail -n +3 | cut -d' ' -f1

