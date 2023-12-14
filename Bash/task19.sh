#!/bin/bash 

if [ $# -ne 2 ]
then 
	echo "Wrong number of arguments!"
	exit 1 
fi 

NAME1=$(basename $1 | cut -d "." -f1)
NAME2=$(basename $2 | cut -d "." -f1)

NUMROWS1=$(cat $1 | grep -w $NAME1 | wc -l)
NUMROWS2=$(cat $2 | grep -w $NAME2 | wc -l)

WINNER=""
WINNERNAME=""

if [ $NUMROWS1 -ge $NUMROWS2 ]
then 
	WINNER=$1
	WINNERNAME=$NAME1
else 
	WINNER=$2
	WINEERNAME=$2
fi

cat $WINNER | cut -d " " -f 4- | sort > $WINNERNAME.songs 
