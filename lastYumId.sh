#!/bin/bash
# Author: Michael Steppe

echo -en "$(yum history | sed -n '3 p' | awk -F" " '{ print $1 }') "
echo -e  "# last yum ID provided by lastYumId.sh" 
