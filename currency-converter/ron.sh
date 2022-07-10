#!/bin/bash

# Convert RON to EUR
# Usage: eur [amount 1] [amount 2] ...

#EUR_RON=$(curl -s https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml | grep RON | cut -d= -f3 | tr -d "/>'")
EUR_RON=$(wget -qO - https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml | grep RON | cut -d= -f3 | tr -d "/>'")
RON_EUR=$(bc<<<"scale=4; 1/$EUR_RON")

if [ -z $1 ]; then
    AMOUNT=1
	EUR=$(bc<<<"$AMOUNT * $RON_EUR")
	echo "$EUR eur"
else 
	until [ -z "$1" ]; do
		if [[ $1 =~ ^[0-9]+\.?[0-9]*$ ]]; then
    		AMOUNT=$1
			EUR=$(bc<<<"$AMOUNT * $RON_EUR")
			echo "$EUR eur"
		fi
		shift
	done
fi
