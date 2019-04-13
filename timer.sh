#!/bin/bash

# Sends notification after a number of minutes
# Usage: timer <minutes> [message]

LINK="https://www.youtube.com/watch?v=dQw4w9WgXcQ"

if [ -z "$2" ]; then
    TEXT="Get food"
else
    TEXT="$2"
fi

sleep $(($1*60)) && notify-send "$TEXT" && browse "$LINK" &

