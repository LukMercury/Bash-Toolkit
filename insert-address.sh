#!/bin/bash

ADDRESS_FILE="$HOME/Documents/Notite/MyAddress.txt"

ADDRESS="$(cat "$ADDRESS_FILE")"

echo "$ADDRESS" | xclip -selection c

