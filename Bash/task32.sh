#!/bin/bash 

if [ $# -ne 2 ] 
then 
	echo "Number of arguments should be 2"
	exit 1
fi 

if ! [ -f $1 ] || ! [ -f $2 ] 
then 
	echo "The two arguments should be existing files"
	exit 2
fi 

IN=$1
OUT=$2

while read line 
do
	if [ $(cat $IN | egrep "^[0-9]+,$line$" | wc -l) -gt 1 ]
	then 
		ID=$(cat $IN | egrep "^[0-9]+,$line$" | cut -d , -f1 | sort -n | head -n 1)
		echo "$ID,$line" >> $OUT
	else
		cat $IN | egrep "^[0-9]+,$line$" >> $OUT
	fi
done< <(cat $IN | cut -d , -f2- | sort | uniq)


