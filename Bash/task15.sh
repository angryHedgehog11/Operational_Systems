#!/bin/bash

if [ $# -ne 1 ] 
then 
	echo "Wrong number of arguments!"
	exit 1
fi 

if ! [ -d $1 ] 
then 
	echo "Given argument should be a direcotry"
	exit 2
fi 

find -L $1 -type l 
