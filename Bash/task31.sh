#!/bin/bash

if [ $# -ne 2 ] 
then 
	echo "There should be 2 arguments"
	exit 1
fi 

if ! [ -d $1 ] || [ $(find $1 | wc -l) -ne 1 ]
then 
	echo "the first argument should be an existing empty dir"
	exit 2 
fi 

DIR=$1 
FILE=$2 
COUNT=0

touch dict.txt

while read person 
do
  echo "$person : $COUNT" >> dict.txt
	FILENAME=$COUNT	
	touch $FILENAME 
	cat $FILE | tr -s " " | sed "s/^ //g" | tr -s "/t" | sed "s/^\t//g" |  egrep "^$person" | cut -d : -f2 >> $FILENAME
	mv $FILENAME $DIR
	COUNT=$(( $COUNT + 1 ))
done< <(cat $FILE | cut -d : -f1 | tr -s " " | sed "s/^ //g" | tr -s "/t" | sed "s/^\t//g" | cut -d " " -f1,2 | sort | uniq)
