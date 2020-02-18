#!/bin/bash

# List playlist contents

PLAYLIST_FOLDER=$HOME/.config/cmus/playlists

if [ -f "${PLAYLIST_FOLDER}/${*}" ]; then 
    vim "${PLAYLIST_FOLDER}/${*}"
fi

