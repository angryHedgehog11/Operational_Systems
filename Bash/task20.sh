#!/bin/bash 

if [ $# -ne 1 ]
then 
	echo "Wrong number of arguments!"
	exit 1
fi 

cat -n $1 | sed -r "s/^\s+//g" | sed "s/^[0-9]*/&\./g" | tr "\t" " " | cut -d " " -f 1,5- | sort -k2  
