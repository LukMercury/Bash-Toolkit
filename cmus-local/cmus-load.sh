#!/bin/bash

# Load a playlist to cmus

PLAYLIST_FOLDER=~/Dropbox/Documents/Playlists

if [ -f "$PLAYLIST_FOLDER/$1.pl" ]; then
    cmus-remote -c "$PLAYLIST_FOLDER/$1.pl"
fi

