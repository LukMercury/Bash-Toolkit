#!/bin/bash

# Play an internet video in vlc
# First copy the video link to the clipboard  
# xclip must be installed for this script to work

# Get link from clipboard or as parameter
if [ -z "$1" ]; then
    STREAM="$(xclip -selection c -o)"
else
    STREAM="$1"
fi

# Prepend https://www.twitch.tv to link if necessary
if [ -z "$(echo $STREAM | grep http)" ]; then
    STREAM="https://www.twitch.tv/$STREAM"
fi

nohup vlc "$STREAM" &> /dev/zero &

