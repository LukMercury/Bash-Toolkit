#!/bin/bash

# Save current cmus playlist 

PLAYLIST_FOLDER=~/Dropbox/Documents/Playlists

cmus-remote -C "save -p $PLAYLIST_FOLDER/$1.pl"

