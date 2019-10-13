#!/bin/bash

# Sends notification after a number of minutes
# Usage: timer <minutes> [message]
#   Display amount of time timer has been running:
#        timer up

LINK="https://www.youtube.com/watch?v=dQw4w9WgXcQ"

if [ "$1" == "up" ]; then
    ps -eo comm,etime | grep timer | head -n-1 | tr -s [:blank:] | cut -d' ' -f2
    exit 0
fi

if [ -z "$2" ]; then
    TEXT="Get food"
else
    TEXT="$2"
fi

sleep $(($1*60)) && notify-send "$TEXT" && browse "$LINK" &

