#!/bin/bash

if [ -z $1 ]; then
    exit 0
fi

grep -i "$*" $HOME/.zsh_history | cut -d';' -f2 

