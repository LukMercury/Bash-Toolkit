#!/bin/bash

ACTIVE_WINDOW=$(xdotool getactivewindow)
FIREFOX=$(xdotool search --onlyvisible --name firefox)

if [ -z $FIREFOX ]; then
    nohup firefox &> /dev/null &
    exit 0
fi

if [ $ACTIVE_WINDOW -eq $FIREFOX ]; then
    xdotool search --onlyvisible --name firefox windowminimize
else
    xdotool search --onlyvisible --name firefox windowactivate
fi
