#!/bin/bash

# Start and minimize GKraken at startup

nohup streamdeck &> /dev/null  &

sleep 3

xdotool search --name Stream\ Deck\ UI windowactivate 
xdotool mousemove 920 45
xdotool click 1
xdotool mousemove 960 540

