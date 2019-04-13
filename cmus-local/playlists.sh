#!/bin/bash

# List current playlists

PLAYLIST_FOLDER=~/Dropbox/Documents/Playlists

ls -1 $PLAYLIST_FOLDER/*.pl | rev | cut -d'/' -f1 | rev | cut -d'.' -f1

