#!/bin/bash

# Load a playlist to cmus

PLAYLIST_FOLDER=$HOME/.config/cmus/playlists

if [ -f "${PLAYLIST_FOLDER}/${*}" ]; then
    cmus-remote -c "${PLAYLIST_FOLDER}/${*}"
fi

