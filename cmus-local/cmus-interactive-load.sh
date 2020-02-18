#!/bin/bash

# Load playlist to cmus interactively

PLAYLIST_FOLDER=$HOME/.config/cmus/playlists

echo -e "Load playlist:\n"
ls -1 "$PLAYLIST_FOLDER" | rev | cut -d'/' -f1 | rev

echo -en "\n> "
read PLAYLIST

if [ -f "${PLAYLIST_FOLDER}/${PLAYLIST}" ]; then
    cmus-remote -c "${PLAYLIST_FOLDER}/${PLAYLIST}"
fi

