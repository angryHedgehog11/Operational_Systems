#!/bin/bash 

if [ $# -ne 2 ]
then 
	echo "Wrong number of arguments"
	exit 1
fi 

if ! [[ $1 =~ ^[0-9]+$ && $2 =~ ^[0-9]+$ ]]
then 
	echo "Both arguments should be numbers"
	exit 2 
fi 

mkdir ./a 
mkdir ./b
mkdir ./c 

while read filename 
do 
	numrows=$(cat $filename | wc -l)
	if [ $numrows -le $1 ]
	then
		mv ./$filename a/$filename
	elif [ $numrows -gt $1 ] && [ $numrows -le $2 ]
	then
		mv ./$filename b/$filename
	else
		mv ./$filename c/$filename
	fi 
done < <(find . -type f)
