#!/bin/bash

# Save current cmus playlist interactively

PLAYLIST_FOLDER=~/Dropbox/Documents/Playlists

echo -en "Save playlist as:\n\n> "
read PLAYLIST

cmus-remote -C "save -p $PLAYLIST_FOLDER/$PLAYLIST.pl"

