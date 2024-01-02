#!/bin/bash

if [ $# -eq 0 ] || [ $# -gt 2 ] 
then 
	echo "Wrong number of arguments"
	exit 1
fi 

if ! [ -d $1 ] 
then 
	echo "First argument should be an exisiting dir"
	exit 2
fi 

DIR=$1


all_syms=$(mktemp)
broken_syms=$(mktemp)
not_broken_syms=$(mktemp)

find $1 -type l > all_syms 
find -L $1 -type l > broken_syms

grep -v -f broken_syms all_syms > not_broken_syms

NUM_BROKEN=$(cat broken_syms | wc -l)

while read symlink 
do 
	name=$(basename $symlink)
	path=$(dirname $symlink)

	if [ $# -eq 2 ] 
	then 
		echo "$name -> $path" >> $2
	else 
		echo "$name -> $path"
	fi 
done < <(cat not_broken_syms)

if [ $# -eq 2 ] 
then 
	echo "Number of broken symlinks: $NUM_BROKEN"
else
	echo "Number of broken symlinks: $NUM_BROKEN" >> $2
fi 

rm all_syms
rm broken_syms
rm not_broken_syms
