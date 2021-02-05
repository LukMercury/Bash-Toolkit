#!/bin/bash

DIR="$HOME/Dropbox/Scripts"
INPUT_FILE="$DIR/cmd_input.txt"
DATA_FILE="$DIR/cmd_data.txt"

# edit
if [ $1 ] && [ $1 == "e" ]; then
    vim "$INPUT_FILE"
    echo 0 > $DATA_FILE
    exit 0
fi

# list
if [ $1 ] && [ $1 == "l" ]; then
    cat -n "$INPUT_FILE"
    exit 0
fi

# reset counter
if [ $1 ]; then 
    if [ $1 == "r" ] || [ $1 -eq 0 ]; then
        echo 0 > $DATA_FILE
        exit 0
    fi
fi

# init
LEN=$(wc -l < $INPUT_FILE)

if [ ! -f $DATA_FILE ]; then 
    echo 0 > $DATA_FILE
    echo "Data file created, start again"
    exit 1
fi
COUNTER=$(cat $DATA_FILE)
if ! [[ "$COUNTER" =~ ^[0-9]+$ ]]; then
    echo 0 > $DATA_FILE
    echo "Data file fixed, start again"
    exit 1
fi
if [ $COUNTER -ge $LEN ]; then
    COUNTER=0
fi

for i in $(seq $LEN); do  
    COM+=("$( head -n $i $INPUT_FILE | tail -1)")
done

# next
if [ -z "$1" ]; then
    ((COUNTER++))
    echo $COUNTER > $DATA_FILE
    echo ${COM[$(($COUNTER-1))]}
    echo ${COM[$(($COUNTER-1))]} | xclip
    exit 0
fi

# number
if [[ "$1" =~ ^[0-9]+$ ]]; then
    echo ${COM[$(($1-1))]}
    echo ${COM[$(($1-1))]} | xclip
    echo $1 > $DATA_FILE
fi
