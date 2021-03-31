#!/bin/bash

DIR="$HOME/Scripts"
INPUT_SEL="$DIR/cmd_inputfile_sel.txt"

if [ ! -f $INPUT_SEL ]; then 
    echo "cmd_input.txt" > $INPUT_SEL
    echo "Input selection file created, start again"
    exit 1
fi

INPUT_FILE="$DIR/$(cat $INPUT_SEL)"
DATA_FILE="$DIR/cmd_data.txt"

# choose input file
if [ $1 ] && [ $1 == "f" ]; then
    if [ $2 ]; then
        echo $2 > $INPUT_SEL
    else
        echo -n "Enter new input file: "
        read NEW_INPUT_FILE
        echo $NEW_INPUT_FILE > $INPUT_SEL
    fi
    echo 0 > $DATA_FILE
    exit 0
fi

# edit
if [ $1 ] && [ $1 == "e" ]; then
    nvim "$INPUT_FILE"
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
