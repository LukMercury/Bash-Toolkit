#!/bin/bash

# Load playlist to cmus interactively

PLAYLIST_FOLDER=~/Dropbox/Documents/Playlists

echo -e "Load playlist:\n"
ls -1 $PLAYLIST_FOLDER/*.pl | rev | cut -d'/' -f1 | rev | cut -d'.' -f1

echo -en "\n> "
read PLAYLIST

if [ -f "$PLAYLIST_FOLDER/$PLAYLIST.pl" ]; then
    cmus-remote -c "$PLAYLIST_FOLDER/$PLAYLIST.pl"
fi

