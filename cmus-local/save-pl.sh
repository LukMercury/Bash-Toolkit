#!/bin/bash

# Save current cmus playlist 

PLAYLIST_FOLDER=$HOME/.config/cmus/playlists

if [ ! -d "$PLAYLIST_FOLDER" ]; then
    mkdir -p "$PLAYLIST_FOLDER"
fi

cmus-remote -C "save"
cmus-remote -C "pl-rename $*"

