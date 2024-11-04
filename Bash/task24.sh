#!/bin/bash 

if [ $# -lt 1 ] || [ $# -gt 2 ] 
then 
	echo "Wrong number of arguments"
	exit 1 
fi 

if ! [ -d $1 ] 
then 
	echo "First mandatory argument should be an existing dir"
	exit 2 
fi 

if [ $# -eq 2 ] && ! [[ $2 =~ ^[0-9]+$ ]] 
then 
	echo "If there is a second argument, it should be a number"
	exit 3 
fi 

DIR=$1

if [ $# -eq 2 ] 
then  
	while read file hardlinks && [ $hardlinks -ge $2 ] 
	do
		echo "$file : $hardlinks"
	done< <(find $DIR -type f -printf "%f %n\n" 2>/dev/null | sort -t " " -k 2,2 -nr | cut -d " " -f 1,2)
else
	find -L $DIR -type l  
fi 
