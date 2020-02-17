#!/bin/bash

# Save current cmus playlist 

PLAYLIST_FOLDER=~/Dropbox/Documents/Playlists

if [ ! -d "$PLAYLIST_FOLDER" ]; then
    mkdir -p "$PLAYLIST_FOLDER"
fi

cmus-remote -C "save -p ${PLAYLIST_FOLDER}/${*}.pl"

