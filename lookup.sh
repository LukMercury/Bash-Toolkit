#!/bin/bash

# Wrapper for dict
# Usage: lookup [language] <word>
#        default language: English

if [ -z "$2" ]; then
    dict -d gcide "$1" | less
elif [ "$1" == "en" ]; then
    dict -d gcide "$2" | less
elif [ "$1" == "thesaurus" ]; then
    dict -d moby-thesaurus "$2" | less
elif [ "$1" == "de" ] || [ "$1" == "ger" ]; then
    dict -d fd-deu-eng "$2" | less
elif [ "$1" == "to-de" ] || [ "$1" == "to-ger" ]; then
    dict -d fd-eng-deu "$2" | less
elif [ "$1" == "ro" ]; then
    dict -d fd-eng-rom "$2" | less
else
    echo "Unknown language"
    echo "type: lookup [language] [word]"
    echo -e "Languages:
    eng
    thesaurus
    deu ger
    to-deu to-ger"
fi

