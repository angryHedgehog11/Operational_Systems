#!/bin/bash 

cat /etc/passwd | grep -w Inf | cut -d ":" -f 1,5 | cut -d "," -f 1  | egrep a$ | cut -c 3,4 | sort -n | uniq -c | sort -rn | head -n 1  
