#!/bin/bash

TERMINOLOGY=$(xdotool search --class terminology)
ACTIVE_WINDOW=$(xdotool getactivewindow)

if [ -z $TERMINOLOGY ]; then
    nohup terminology &> /dev/null &
    exit 0
fi

if [ $ACTIVE_WINDOW -eq $TERMINOLOGY ]; then
    xdotool search --class terminology windowminimize
else
    xdotool search --class terminology windowactivate
fi
