#!/bin/bash

# Start and minimize GKraken at startup

nohup flatpak run com.leinardi.gkraken &> /dev/null  &

sleep 5

flatpak kill com.leinardi.gkraken &> /dev/null 

