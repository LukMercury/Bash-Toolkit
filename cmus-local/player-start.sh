#!/bin/bash

# Start cmus music player in a tmux session

xdotool search --class terminology windowactivate

ps -e | grep cmus | grep -v \<defunct\> &> /dev/null || tmux new-window -ncmus 'cmus' && tmux swap-window -t0
