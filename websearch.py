#!/usr/bin/env python3

import sys
from os import system

browser = 'browse'
search_engine = 'https://duckduckgo.com/'

# Launch search engine in browser
command = f'nohup {browser} {search_engine}'

no_args = len(sys.argv)

# Add query for search terms
if no_args > 1:
	command = command + '?q='
	for arg in sys.argv[1:-1]:
		command = command + arg + '+'
	command = command + sys.argv[len(sys.argv) - 1]

# Add redirection of output stream and launch in background to command
command = command + "> /dev/null 2>&1 &"

system(command)
