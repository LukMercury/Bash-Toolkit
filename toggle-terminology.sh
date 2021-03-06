#!/bin/bash

ACTIVE_WINDOW=$(xdotool getactivewindow)
TERMINOLOGY=$(xdotool search --class terminology)

if [ $ACTIVE_WINDOW -eq $TERMINOLOGY ]; then
    xdotool search --class terminology windowminimize
else
    xdotool search --class terminology windowactivate
fi
