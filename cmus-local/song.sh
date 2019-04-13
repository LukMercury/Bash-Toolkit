#!/bin/bash

# Display currently playing

notify-send "Currently playing" "~/$(cmus-remote -C status | head -2 | tail -1 | cut -d' ' -f2- | cut -d'/' -f4-)"

