#!/bin/bash 

while read dir 
do
	if ! [ -d $dir ]
	then 
		continue
	fi
	find $dir -type f -printf "%T@ %p %u\n" 2>/dev/null

done < <(cut -d ':' -f 6 /etc/passwd | tr " " "\t") | sort -rn -k2,2 | head -n 1 | cut -d " " -f 2,3 
