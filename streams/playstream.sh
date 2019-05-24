#!/bin/bash

# Play an internet video as wallpaper
# First copy the video link to clipboard  
# xclip must be installed for this script to work
# If you don't use tmux remove all the tmux and WINDOW_NAME lines and just use:
# nohup vlc "$STREAM" &> /dev/null &

# Get link from clipboard or as parameter
if [ -z $1 ]; then
    STREAM="$(xclip -selection c -o)"
else
    STREAM="$1"
fi

# Prepend https:// to link if necessary
if [ -z "$(echo $STREAM | grep http)" ]; then
    STREAM="https://$STREAM"
fi

nohup vlc $STREAM &> /dev/null &

