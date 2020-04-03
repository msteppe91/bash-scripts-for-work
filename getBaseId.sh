#!/bin/bash
# Author: Michael Steppe

baseIdFile="/etc/SNA-yumIDs"
tail -1 ${baseIdFile} | awk -F" " '{ print $1 }'
