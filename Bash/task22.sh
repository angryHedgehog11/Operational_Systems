#!/bin/bash 

if [ $# -ne 1 ]
then 
	echo "Wrong number of arguments!"
	exit 1 
fi 

if [ $(id -u) -ne 0 ]
then 
  echo "Script should be run by root"
  exit 2
fi

USER=$1
ps -e -o user | sort | uniq -c | sort -nr | tr -s " " | cut -d " " -f3 > users.txt 

USERS_WITH_MORE_PR=$(sed "/$USER/Q" users.txt)

echo "The following users: $USERS_WITH_MORE_PR are with more processes than $USER"

ALL_PR=$(ps -e | wc -l)

TIME_PR=0 

EPOCH='jan 1 1970'

while read line 
do 
	TIME_PR="$(date -u -d "$EPOCH $line" +%s) + $TIME_PR"
done < <(ps -e -o time=)

TIME_PR=$( echo $TIME_PR | bc)


AVG=$(( $TIME_PR / $ALL_PR ))

echo "Average time for all processes is: $(date -d@"$AVG" -u +%H:%M:%S)" 

while read line 
do
	TIME=$(echo $line | cut -d " " -f3)
	TIME_IN_SECS=$(date -u -d "$EPOCH $TIME" +%s)
	if [ $TIME_IN_SECS -gt $AVG ]
	then
		PID=$(echo $line | cut -d " " -f2)
		echo "kill $PID"
		sleep 1 
		echo "kill -9 ${PID}" 
	fi
done < <(ps -e -o user=,pid=,time= | egrep $USER)

