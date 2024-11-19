#!/bin/bash

if [ $# -gt 1 ] 
then 
	echo "This script should take only one argument"
	exit 1 
fi 

if ! [ -d $1 ]
then 
	echo "The first argument should be an existing dir"
	exit 2
fi 

DIR=$1
FRIENDS=$(mktemp) 

while read friend
do
	TOTALROWS=$(find $DIR -type f | egrep -w $friend | egrep -w [0-2][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]-[0-6][0-9]-[0-6][0-9]-[0-6][0-9].txt | xargs wc -l | tail -n 1 | rev | cut -d " " -f2 | rev)
	echo "$friend : $TOTALROWS" >> $FRIENDS 
done< <(find $DIR -mindepth 3 -maxdepth 3 -type d | cut -d "/" -f 4 | sort | uniq) 

cat $FRIENDS | sort -nr -t ":" -k2,2 | head -n 10 

rm -rf $FRIENDS
