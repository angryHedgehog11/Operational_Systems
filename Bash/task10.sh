#!/bin/bash 

find /home/SI -type d -newertnt 1551168000 \! -newertnt 1551176100 2>/dev/null > dirs.txt

grep -f dirs.txt /etc/passwd | cut -c 2- | cut -d ":" -f 1,5 | cut -d "," -f 1 | tr -s ":" "\t"
