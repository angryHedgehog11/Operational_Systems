#!/bin/bash 

if [ $# -lt 1 ] || [ $# -gt 2 ]
then 
	echo "Wrong number of arguments"
	exit 1
fi 

if ! [ -d $1 ]
then 
	echo "First parameter should be existing directory"
	exit 2
fi 

DIR=$1 

if [ -z $2 ] 
then 
	find -L $DIR -type l 
else
  #we assume that the second parameter is always a number 
	find $DIR -type f -printf "%p %n\n" | egrep -w $2 | cut -d " " -f1 
fi 
