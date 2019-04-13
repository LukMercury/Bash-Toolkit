#!/bin/bash

# Convert RON to EUR
# Usage: ron [amount]

EUR_RON=$(curl -s https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml | grep RON | cut -d= -f3 | tr -d "/>'")
RON_EUR=$(bc<<<"scale=4; 1/$EUR_RON")

if [ -z $1 ]; then
    AMOUNT=1
elif [[ $1 =~ ^[0-9]+$ ]]; then
    AMOUNT=$1
else
    echo "Amount must be a number"
    exit 1
fi

EUR=$(bc<<<"$AMOUNT * $RON_EUR")

echo "$EUR eur"

