#!/bin/bash

ADDRESS_FILE="$HOME/Dropbox/Documents/Notite/MyAddress.txt"

ADDRESS="$(cat "$ADDRESS_FILE")"

echo "$ADDRESS" | xclip -selection c

# this is a test line
