#!/bin/bash 

GROUP=$(cat /etc/passwd | cut -c 2- | sort -n | head -n 201 | tail -n 1 | cut -d ":" -f 4)

cat /etc/passwd | egrep $GROUP | cut -c 2- | sort -n | cut -d ":" -f 5,6 | tr -s "," ":" | cut -d ":" -f 1,5 
