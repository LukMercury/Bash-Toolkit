#!/bin/bash

# Wrapper from sending email interactively with bash mail
# For convenient use with a taskbar launcher
# Launcher would run something like: terminology -e /path/to/script
# Minimal resoureces, fast operation, terminal window closes automatically
# named "send-email" to differentiate from "sendmail"

ADDRESS_BOOK="$HOME/Dropbox/Documents/Notite/Address Book.txt"
MY_EMAIL="mihailuca406@gmail.com"

getAddress()
{
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
}

echo -n "Send email to: "
read RECIPIENT
echo "$RECIPIENT" | grep '@' &> /dev/null && SEND_TO="$RECIPIENT" || SEND_TO=$(getAddress $RECIPIENT) # no "" 

echo -n "Subject: "
read SUBJECT

vim -c 'startinsert' new-email.txt 
if [ -f new-email.txt ]; then
    <new-email.txt mail -s "$SUBJECT" "$SEND_TO"
    rm new-email.txt
fi

echo -n "Attach file: "
read ATTACHMENT
if [ ! -z "$ATTACHMENT" ]; then
    echo "file" | mail -s "$SUBJECT" -A "$ATTACHMENT" "$SEND_TO"
fi

