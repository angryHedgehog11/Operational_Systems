#!/bin/bash 

if [ $# -ne 2 ]
then 
	echo "Wrong number of arguments"
	exit 1
fi 

if ! [ -d $1 ] 
then 
	echo "First argument must be an exisiting dir"
	exit 2
fi

DIR=$1 
STR=$2 

find $DIR -maxdepth 1 -type f -name "vmlinuz-[0-9]*.[0-9]*.[0-9]*-$STR" -printf "%f\n" 2>/dev/null | sort -nr -t '.' -k1,1 -k2,2 -k3,3 
