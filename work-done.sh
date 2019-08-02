#!/bin/bash

# Lists the files modified since system startup
# Usage: work-done [folder]

FOLDER=/home/$USER/Dropbox
if [ ! -z "$1" ]; then
    FOLDER="$1"
fi
HOURS=$(uptime -p | cut -d' ' -f2)
MINUTES=$(uptime -p | cut -d' ' -f4)
if [ -z "$MINUTES" ]; then  
    MINUTES="$HOURS"  # if no MINUTES, HOURS actually means MINUTES
    TIME="$MINUTES"
else 
    let TIME="$HOURS*60 + $MINUTES"
fi

find "$FOLDER" -type f -mmin -"$TIME" 2> /dev/null | grep -v '.git' | grep -v '.dropbox'

