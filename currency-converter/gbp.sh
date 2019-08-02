#!/bin/bash

# Convert USD to RON
# Usage: usd [amount]

EUR_RON="$(curl -s https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml | grep RON | cut -d= -f3 | tr -d "/>'")"
EUR_GBP="$(curl -s https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml | grep GBP | cut -d= -f3 | tr -d "/>'")"

GBP_RON="$(bc<<<"scale=4; $EUR_RON/$EUR_GBP")"

if [ -z "$1" ]; then
    AMOUNT=1
elif [[ "$1" =~ ^[0-9]+\.?[0-9]*$ ]]; then
    AMOUNT="$1"
else
    echo "Amount must be a number"
    exit 1
fi

RON="$(bc<<<"$AMOUNT * $GBP_RON")"

echo "$RON ron"

