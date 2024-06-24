#!/bin/bash 

find . -type f -size 0c 2>/dev/null | xargs rm -rf

HOMEDIR=$(egrep $(whoami) /etc/passwd | cut -d : -f 6)

find $HOMEDIR -type f -printf "%p %s\n" 2>/dev/null | sort -nr -k 2 | cut -d " " -f 1 | head -n 5 | xargs rm -rf
