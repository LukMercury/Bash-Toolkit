#!/bin/bash

# Start and minimize GKraken at startup

nohup flatpak run com.leinardi.gkraken &> /dev/null  &

flatpak kill com.leinardi.gkraken &> /dev/null 

