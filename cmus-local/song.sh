#!/bin/bash

# Display currently playing

echo "~/$(cmus-remote -C status | head -2 | tail -1 | cut -d' ' -f2- | cut -d'/' -f4-)"
notify-send "Currently playing" "~/$(cmus-remote -C status | head -2 | tail -1 | cut -d' ' -f2- | cut -d'/' -f4-)"

