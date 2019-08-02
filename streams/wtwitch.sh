#!/bin/bash

# Play an internet video as wallpaper
# First copy the video link to the clipboard  
# xclip must be installed for this script to work
# If you don't use tmux remove all the tmux and WINDOW_NAME lines and just use:
# cvlc --video-wallpaper "$STREAM"

# Get link from clipboard or as parameter
if [ -z $1 ]; then
    STREAM="$(xclip -selection c -o)"
else
    STREAM="$1"
fi

# Prepend https://www.twitch.tv to link if necessary
if [ -z "$(echo $STREAM | grep http)" ]; then
    STREAM="https://www.twitch.tv/$STREAM"
fi

# Name the tmux window running the cvlc command
WINDOW_NAME="$(echo $STREAM | rev | cut -d'/' -f1 | rev)"

ps -e | grep tmux &> /dev/null || tmux
echo "Streaming in wallpaper mode. Use Ctrl-C in the \"$WINDOW_NAME\" window to exit."

tmux new-window -n"$WINDOW_NAME" "cvlc --video-wallpaper $STREAM"
tmux select-window -p

