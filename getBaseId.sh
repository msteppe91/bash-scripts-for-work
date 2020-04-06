#!/bin/bash
# Author: Michael Steppe

baseIdFile="/etc/SNA-yumIDs"

# This will break if that last line is empty
#tail -1 ${baseIdFile} | awk -F" " '{ print $1 }'

# Instead:
#   print the contents of the file in reverse order with tac
#   grep for the first matching non-empty line
#   pull off the first set of characters (space delimited)
baseId=$(tac ${baseIdFile} | grep -m 1 . | awk -F " " '{ print $1 }')

# Test that the baseId is a positive integer
re='^[0-9]+$'
if [[ ! ${baseId} =~ ${re} ]] ; then
    echo "Error: Not a number"
    exit 1 # we will need to fail gracefully here in the Jenkinsfile that calls this script
fi
