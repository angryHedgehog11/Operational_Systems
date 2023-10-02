#!/bin/bash

find $(cat /etc/passwd | cut -d ":" -f 3,6 | egrep "^$(id -u pesho)" | cut -d ":" -f 2) -type f -printf "%n %T@ %i\n" 2>/dev/null | egrep -w "^1" -v | sort -k 2 -n | head -n 1 | cut -d " " -f 3 
