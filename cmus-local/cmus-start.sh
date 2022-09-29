#!/bin/bash

# Start cmus music player in a tmux session

xdotool search --class terminology windowactivate

tmux new-window -ncmus 'cmus'
tmux swap-window -t 0
