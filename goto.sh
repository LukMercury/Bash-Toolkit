#!/bin/bash

# Depending on the parameter passed:
# Number: Opens a numbered link from a Bookmarks file in the default browser
#         Works well together with bookmark.sh (bookmark -l lists your bookmarks)
# Path to File: Follows all links (containing http) in that file
# Usage: goto <line number>
#        goto <file name>

LOG_FILE=/home/$USER/Dropbox/Documents/Notite/useful-links.txt
FOUND_LINK=1

if [[ "$1" =~ ^[0-9]+$ ]]; then
    nohup firefox --new-window $(cat "$LOG_FILE" | head -n "$1" | tail -1) &> /dev/null
elif [ -f "$1" ]; then
    for LINK in $(grep http "$1" | tr [:blank:] '\n' | grep http) ; do
        nohup firefox --new-window $LINK &> /dev/null
        FOUND_LINK=0
    done
    for LINK in $(grep www "$1" | tr [:blank:] '\n' | grep www | grep -v http) ; do
        nohup firefox --new-window "https://$LINK" &> /dev/null
        FOUND_LINK=0
    done
    if [ "$FOUND_LINK" -eq 1 ]; then
        echo "No links in file $1"
    fi
else
    echo "Parameter must be a number or a file name"
fi

