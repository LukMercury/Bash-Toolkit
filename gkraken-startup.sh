#!/bin/bash

# Start and minimize GKraken at startup

nohup nohup flatpak run com.leinardi.gkraken &> /dev/null  &

xdotool search --class gkraken  windowclose
