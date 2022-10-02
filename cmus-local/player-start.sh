#!/bin/bash

# Start cmus music player in a tmux session
# If cmus is started bring it to front

xdotool search --class terminology windowactivate

ps -e | grep cmus | grep -v '<\defunct\>' &> /dev/null
if [ $? -eq 0 ]; then
    xdotool key ctrl+b
    xdotool key 0
    exit 0
fi

ps -e | grep cmus | grep -v '\<defunct\>' &> /dev/null || tmux new-window -ncmus 'cmus' && tmux swap-window -t0
xdotool key ctrl+b
xdotool key 0

