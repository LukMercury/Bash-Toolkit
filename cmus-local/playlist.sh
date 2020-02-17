#!/bin/bash

# List playlist contents

PLAYLIST_FOLDER=~/Dropbox/Documents/Playlists

if [ -f "${PLAYLIST_FOLDER}/${*}.pl" ]; then 
    vim "${PLAYLIST_FOLDER}/${*}.pl"
fi

