#!/bin/bash 

if [ $# -ne 3 ]
then 
	echo "Wrong number of arguments"
	exit 1
fi 

if ! [ -d $1 ] 
then 
	echo "First argument must be existing directory"
	exit 2
fi 

if ! [ -d $2 ] 
then 
	echo "Second argument must be existing directory"
	exit 3
fi 

if ! [ -z "$(ls -A $2)" ]
then 
	echo "Second dir must me empty"
	exit 4
fi

if [ $(id -u) -ne 0 ] 
then 
  echo "Script must be run from root"
	exit 5
fi 

SRC=$1
DST=$2 
STR=$3

while read file
do
	NEW_NAME=$(echo $file | sed -e "s/^$SRC/$DST/")
	mkdir -p $(dirname $NEW_NAME)
	mv $file $NEW_NAME
done < <(find $SRC -type f -name "*$STR*") 
