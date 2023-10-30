#!/bin/bash 

if [ $(id -u) -ne 0 ]
then 
	echo "Script should be executed by root"
	exit 1
fi 

while read line
do 
	user=$(echo $line | cut -d ":" -f 1)
	home=$(echo $line | cut -d ":" -f 6)
	if [ -z $home ]
	then 
		echo "$user has no homedir"
		continue 
	fi 
	if [[ $home =~ */nologin ]] 
	then 
		echo "$user has $home homedir which is not a dir"
		continue
	fi 
	dirperm=$(stat -c "%A" $home 2>/dev/null)
	dirowner=$(stat -c "%U" $home 2>/dev/null)
	if [[ $dirowner != $user ]]
	then 
		echo "User is not owner of $home"
		continue
	fi 
	if [[ $(echo $dirperm | cut -c 3) != 'w' ]] 
	then 
		echo "$user can not write in $home"
		continue
	fi 
done < <(cat /etc/passwd)
