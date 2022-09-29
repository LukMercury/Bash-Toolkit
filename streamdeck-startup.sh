#!/bin/bash

# Start and minimize GKraken at startup

nohup streamdeck &> /dev/null  &

sleep 4

xdotool search --name Stream\ Deck\ UI windowclose 

