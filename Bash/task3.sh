#!/bin/bash 

find . -type f -size 0c 2>/dev/null | xargs rm  

find . -type f -printf "%p %s\n" 2>/dev/null | sort -nr -k 2 | cut -d " " -f 1 | head -n 5 | xargs rm
