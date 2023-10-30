#!/bin/bash

if [ $# -ne 1 ] 
then 
	echo "Wrong number of arguments"
	exit 1
fi 

if ! [[ $1 =~ ^[0-9]+$ ]] 
then 
	echo "Arguments should be number"
	exit 2 
fi

if [ $(id -u) -ne 0 ] 
then 
	echo "Script should be executed by root"
	exit 3
fi 

for u in $(ps -e -o user= | sort | uniq)
do 
	maxpid=0 
	maxrss=0
	rsssum=0
	while read p r 
	do 
		if [ $r -gt $maxrss ] 
		then 
			maxrss=$r
			maxpid=$p
		fi
		rsssum=$((rsssum + r))
	done < <(ps -u $u -o pid= -o rss= | sort -n -k 2)
	echo "u: $u , rsssum: $rsssum , maxrss: $maxrss , maxpid: $maxpid"
	if [ $rsssum -gt $1 ] 
	then 
		echo "kill $maxpid"
		sleep 1 
		echo "kill -9 ${maxpid}"
	fi
done 
