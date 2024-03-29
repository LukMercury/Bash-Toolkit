#!/bin/bash

# Adds clipboard entry (link copied from Browser Address Bar) to a list
# Has a few basic options: list, search, get (to clipboard), edit, 
# delete, re-add last deleted, backup, clear, import, help
# Version to be used with Stream Deck Buttons (uses notify-send)

LOG_FILE=$HOME/Documents/Notite/useful-links.txt
BACKUP_FILE=$HOME/Documents/Notite/backup.useful-links.txt

USAGE="\nDefault - add clipboard entry to Bookmarks
-l, list - list Bookmarks using cat
-lt, list tail - list last ten Bookmarks using tail
-ll, listl - list Bookmarks using less (useful for longer lists)
-s, search - search for terms
-g, get [number] - get Bookmark [number]
-f, follow [number] - open Bookmark [number] in Browser
-e, edit - edit Bookmarks
-d, del, delete [number] - delete last added Bookmark or Bookmark [number]
-r - re-add last deleted Bookmark (if still in clipboard)
-b, backup [filename] - backup (to filename)
-c, clear - clear Bookmarks
-i, import - import Bookmarks from file
-h, help, usage, ? - display this message\n"

# Adds Bookmark from X clipboard
addBookmark()
{
    xclip -selection c -o >> "$LOG_FILE" && echo >> "$LOG_FILE" 
    if [ $? -eq 0 ]; then
        nohup notify-send "Added to Bookmarks:" "$(xclip -selection c -o)" &> /dev/null &
    fi
}

# Re-adds a just deleted Bookmark. Uses secondary clipboard register
reAddBookmark()
{
    xclip -selection s -o >> "$LOG_FILE" && echo >> "$LOG_FILE" 
    if [ $? -eq 0 ]; then
        nohup notify-send "Added to Bookmarks: $(xclip -selection s -o)" &> /dev/null &
    fi
}

case "$1" in
    # List entries using cat with line numbers
    "list" | "-l")
        cat -n "$LOG_FILE"
        ;;
    "listtail" | "-lt")
        cat -n "$LOG_FILE" | tail
        ;;
    # List entries using less
    "listl" | "-ll") 
        less "$LOG_FILE"
        ;;
    # Search for terms
    "search" | "-s")
        if [ -z "$2" ]; then
            echo "Enter search term(s) after 'search'"
        else
            shift
            SEARCH_RESULTS="$(cat -n "$LOG_FILE" | grep -i "$1")"
            shift 
            until [ -z "$1" ]; do
                SEARCH_RESULTS="$(echo "$SEARCH_RESULTS" | grep -i "$1")"
                shift
            done
            echo "$SEARCH_RESULTS"
        fi
        ;;
    # Get last entry (no second argument) or get entry [number]
    "get" | "-g")
        if [ -z "$2" ]; then
            tail -1 "$LOG_FILE" | xclip -selection c
            echo "$(xclip -selection c -o) copied to clipboard"
        elif [[ "$2" =~ ^[0-9]+$ ]]; then   # check if numerical
            head -n "$2" "$LOG_FILE" | tail -1 | xclip -selection c
            echo "$(xclip -selection c -o) copied to clipboard"
        else
            echo "Bad argument after 'get'"
        fi
        ;;
    # Open Bookmark in Browser
    "follow" | "-f")
        shift
        if [ -z "$1" ]; then
            nohup browse $(cat "$LOG_FILE" | tail -1) &> /dev/null
        else
            while [ ! -z $1 ]; do
                if [[ "$1" =~ ^[0-9]+$ ]]; then   # check if numerical
                    nohup browse $(cat "$LOG_FILE" | head -n "$1" | tail -1) &> /dev/null
                else
                    echo "Bad argument after 'follow': $1"
                fi
                shift
            done
        fi
        ;;
    # Search for terms and automatically follow found links
    "search-follow-all" | "-sfa")
        if [ -z "$2" ]; then
            echo "Enter search term(s) after 'search'"
        else
            shift
            SEARCH_RESULTS="$(cat -n "$LOG_FILE" | grep -i "$1")"
            shift 
            until [ -z "$1" ]; do
                SEARCH_RESULTS="$(echo -e "$SEARCH_RESULTS" | grep -i "$1")"
                shift
            done
            readarray -t SEARCH_RESULTS < <(echo "$SEARCH_RESULTS" | tr -s '[:blank:]' ':')
            for RESULT in ${SEARCH_RESULTS[*]}; do
                RESULT=$(echo "$RESULT" | cut -d: -f2)
                nohup browse $(cat "$LOG_FILE" | head -n $RESULT | tail -1) &> /dev/null
            done
        fi
    ;;
    # Manually edit Bookmarks
    "edit" | "-e")
        vim "$LOG_FILE"
        ;;
    # Delete last entry (no second argument) or delete entry [number]
    "delete" | "del" | "-d")
        if [ -z "$2" ]; then
            echo -n "$(tail -1 $LOG_FILE)" | xclip -selection s     # keep in secondary register
            echo "Removed from Bookmarks: $(tail -1 $LOG_FILE)"
            sed -i '$d' "$LOG_FILE"
        elif [[ "$2" =~ ^[0-9]+$ ]]; then   # check if numerical
            echo -n "$(head -n "$2" $LOG_FILE | tail -1)" | xclip -selection s  # keep in secondary register
            echo "Removed from Bookmarks: $(head -n "$2" $LOG_FILE | tail -1)"
            sed -i "$2d" "$LOG_FILE"
        else
            echo "Bad argument after 'delete'"
        fi
        ;;
    # Re-add last deleted entry (at the end of the list)
    "-r")
        reAddBookmark
        ;;
    # Backup Bookmark list to default or named file
    "backup" | "-b")
        if [ ! -z "$2" ]; then
            BACKUP_FILE="$2"
        fi
        cp "$LOG_FILE" "$BACKUP_FILE" > /dev/null && echo "Backup created on $BACKUP_FILE" || echo "Couldn't create backup"
        ;;
    # Clear Bookmark list (old file is moved to Trash)
    "clear" | "-c")
        mkdir -p /home/$USER/.local/share/Trash/files
        cp "$LOG_FILE" /home/$USER/.local/share/Trash/files/
        > "$LOG_FILE"
        echo "Bookmarks cleared"
        ;;
    # Import Bookmark list (overwrites but saves to Trash)    
    "import" | "-i")
        if [ -z "$2" ]; then
            echo "Enter filename after 'import'"
        elif [ ! -f "$2" ]; then
            echo "$2 not found"
        else
            mkdir -p /home/$USER/.local/share/Trash/files
            cp "$LOG_FILE" /home/$USER/.local/share/Trash/files/
            cp "$2" "$LOG_FILE" > /dev/null
            echo "Bookmarks imported from $2"
        fi
        ;;
    # List usage options
    "help" | "-h" | "usage" | "?")
        echo -e "$USAGE"
        ;;
    # No parameter adds clipboard entry to list
    "")
        addBookmark
        ;;
    *)
        echo "Unknown request"
        ;;
esac

