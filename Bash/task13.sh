#!/bin/bash 

mostFailures=$(cat spacex.txt | egrep Failure | cut -d '|' -f 2,3 | sort | uniq -c | sort -n | head -n 1 | cut -d '|' -f 1 | tr -s " " | cut -d ' ' -f 3)

cat spacex.txt | egrep $mostFailures | sort -n | head -n 1 | cut -d '|' -f 3,4 | tr '|' ':'  
