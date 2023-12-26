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

mktemp users.txt
mktemp ps_otput.txt

ps -e -o user=,pid=,time= > ps_output.txt

USER=$1
cat ps_output.txt | cut -d " " -f1 | sort | uniq -c | sort -nr | tr -s " " | cut -d " " -f3 > users.txt 

USERS_WITH_MORE_PR=$(sed "/$USER/Q" users.txt)

echo "The following users: $USERS_WITH_MORE_PR are with more processes than $USER"

ALL_PR=$(cat ps_output.txt | wc -l)

TIME_PR=0 

EPOCH='jan 1 1970'

while read line 
do 
	TIME_PR="$(date -u -d "$EPOCH $line" +%s) + $TIME_PR"
done < <(cat ps_output.txt | cut -d " " -f3)

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
done < <(cat ps_output.txt | egrep $USER)
rm users.txt
rm ps_output.txt
