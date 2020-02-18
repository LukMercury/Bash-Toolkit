#!/bin/bash

# Save current cmus playlist interactively

PLAYLIST_FOLDER=$HOME/.config/cmus/playlists

if [ ! -d "$PLAYLIST_FOLDER" ]; then
    mkdir -p "$PLAYLIST_FOLDER"
fi

echo -en "Save playlist as:\n\n> "
read PLAYLIST

cmus-remote -C "save"
cmus-remote -C "pl-rename $PLAYLIST"

