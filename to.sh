#!/bin/bash

# Returns email addresses from Address Book file to use with 'mail' bash application
# Takes up to 3 search words, returns own email if none or more than one result is found
# Can deal with additional whitespaces entered by mistake
# Address Book file line format is: FirstName LastName Email
# Usage: to <name1> [name2] [name3]
#   with mail: echo "email message" | mail -s "subject" $(to name)

ADDRESS_BOOK="$HOME/Dropbox/Documents/Notite/Address Book.txt"
MY_EMAIL="mihailuca406@gmail.com"

if [ ! -z $3 ]; then
    ADDRESS="$(cat "$ADDRESS_BOOK" | grep -i $1 | grep -i $2 | grep -i $3 | tr -s [:blank:] ' ' | cut -d' ' -f3)"
elif [ ! -z $2 ]; then
    ADDRESS="$(cat "$ADDRESS_BOOK" | grep -i $1 | grep -i $2 | tr -s [:blank:] ' ' | cut -d' ' -f3)"
else
    ADDRESS="$(cat "$ADDRESS_BOOK" | grep -i $1 | tr -s [:blank:] ' ' | cut -d' ' -f3)"
fi

RETURNED_ADDR="$(echo "$ADDRESS" | wc -l)"

if [ -z "$ADDRESS" ]; then
    echo "$MY_EMAIL"
elif [ "$RETURNED_ADDR" -ne 1 ]; then
    echo "$MY_EMAIL"
else
    echo "$ADDRESS"
fi

