#!/bin/bash

# Convert EUR to RON
# Usage: eur [amount]

EUR_RON=$(curl -s https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml | grep RON | cut -d= -f3 | tr -d "/>'")

if [ -z $1 ]; then
    AMOUNT=1
elif [[ $1 =~ ^[0-9]+.?[0-9]*$ ]]; then
    AMOUNT=$1
else
    echo "Amount must be a number"
    exit 1
fi

RON=$(bc<<<"$AMOUNT * $EUR_RON")

echo "$RON ron"

