#!/bin/bash

if [ $(id -u) -ne 0 ]
then
	echo "Script is not ran by root"
	exit 1
fi

ROOT_RSS=$(ps -e -u "root" -o rss= | awk '{i+=$1} END {print i}')

while read user home
do

	[ ! -d "${home}" ] || [ "$(stat -c "%u" ${home})" != "${user}" ] || [ $(ls -ld "${home}") | cut -c 3 != w ] || continue
	
	USER_RSS=$(ps -e -u "${user}" -o rss= | awk '{i+=$1} END {print i}')
	
	if [[ "${USER_RSS}" -gt "${ROOT_RSS}" ]]
  then
		killall -u "${user}" -KILL 
	fi
done < <(cut -d ':' -f 3,6 /etc/passwd)
