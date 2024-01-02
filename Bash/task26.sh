#!/bin/bash 

ps_output=$(mktemp) 
users=$(mktemp) 

ps aux | tail -n +2 | tr -s " " > ps_output 

cat ps_output | cut -d " " -f1 | sort | uniq > users 

while read user
do
	PRC_NUM=$(cat ps_output | grep $user | wc -l)
	ALL_RSS=$(cat ps_output | grep $user | awk '{SUM+=$6;} END {print SUM}')
	MAX_RSS=$(cat ps_output | grep $user | cut -d " " -f6 | sort -nr | head -n 1)
	AVG=$(($ALL_RSS / $PRC_NUM))

	echo "User $user has $PRC_NUM number of proccesses and $ALL_RSS RSS"
	
	COND=$(($AVG*2))
 
	if [ $MAX_RSS -gt $COND ]
	then 
     	PID=$(cat ps_output | grep $user | grep $MAX_RSS | cut -d " " -f 6)
		  echo "Killing process with $PID"
      kill -9 $PID
	fi 

done < <(cat users)

rm users
rm ps_output
