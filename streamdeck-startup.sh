#!/bin/bash

# Start and minimize GKraken at startup

nohup streamdeck &> /dev/null  &

sleep 2

xdotool search --name Stream\ Deck\ UI windowclose 

