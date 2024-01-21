#!/bin/bash 

if [ $# -ne 1 ] 
then 
	echo "Wrong number of arguments"
	exit 1
fi 

if ! [ -d $1 ]
then 
	echo "Argument should be existing dir"
	exit 2
fi 


DIR=$1

files=$(mktemp)
communication=$(mktemp)

find $DIR -type f -name "[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]-[0-9][0-9]-[0-9][0-9]-[0-9][0-9].txt"  > $files 
 
cat $FILE | egrep fr1 | xargs wc -l | tail -n 1 | tr -s " " | cut -d ' ' -f2   

while read fiend 
do 
	ROWS=$(cat $files | egrep $friend | xargs wc -l | tail -n 1 | tr -s " " | cut -d ' ' -f2)
  echo "$ROWS $firend" >> communication
done< <(cat $files | cut -d '/' -f 4 | sort | uniq)

cat communication | sort -nr | head -n 10 

rm $files 
rm $communication 
