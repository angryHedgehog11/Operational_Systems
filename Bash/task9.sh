#!/bin/bash 

TYPE=$(cat planets.txt | tail -n +2 | sort -k 3 -rn -t ";" | head -n 1 | cut -d ";" -f 2)

cat planets.txt | egrep -w $TYPE | sort -k 3 -n -t ";" | head -n 1 | cut -d ";" -f 1,4 | tr -s ";" "\t" 
