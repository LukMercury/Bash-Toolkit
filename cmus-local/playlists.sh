#!/bin/bash

# List current playlists

PLAYLIST_FOLDER=$HOME/.config/cmus/playlists

ls -1 "$PLAYLIST_FOLDER" | rev | cut -d'/' -f1 | rev

