#!/bin/bash

# Adds clipboard entry (link copied from Browser Address Bar) to a list
# Has a few basic options: list, search, get (to clipboard), edit, 
# delete, re-add last deleted, backup, clear, import, help

LOG_FILE=$HOME/Documents/Notite/notes.txt


# Adds Bookmark from X clipboard
addNote()
{
    xclip -selection c -o >> "$LOG_FILE" && echo >> "$LOG_FILE" && echo >> "$LOG_FILE" 
    if [ $? -eq 0 ]; then
        echo "Added note"
        nohup notify-send "Added note" "$(xclip -selection c -o | head -c 45 )..." &
    fi
}


case "$1" in
    # Open notes
    "open" | "-o")
        nohup notepadqq "$LOG_FILE" &> /dev/null &
        ;;
 
    # No parameter adds clipboard content to notes
    "")
        addNote
        ;;
    *)
        echo "Unknown request"
        ;;
esac

