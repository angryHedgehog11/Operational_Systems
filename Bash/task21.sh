#!/bin/bash 

if [ $# -ne 3 ]
then 
	echo "Wrong number of arguments!"
	exit 1 
fi 

if [ -z $1 ] || [ -z $2 ] || [ -z $3 ] 
then 
	echo "None of the arguments should be empty"
	exit 2
fi

FILE=$1
KEY1=$2
KEY2=$3 

if [ $(grep -c -w $KEY1 $FILE) -ne 1 ]  
then 
	echo "The file should have only one row starting with $KEY1"
	exit 3 
fi 

mktemp KEY1_VALUES.txt
grep -w $KEY1 $FILE | cut -d "=" -f2 > KEY1_VALUES.txt 
mktemp KEY2_VALUES.txt

if [ $(grep -c -w $KEY2 $FILE) -le 0 ]
then 
	cat $FILE
	exit 0
elif [ $(grep -c -w $KEY2 $FILE) -gt 1 ]
then 
	echo "The file should have only one row starting with $KEY2"
	exit 4
else  
	grep -w $KEY2 $FILE | cut -d "=" -f2 > KEY2_VALUES.txt
fi 

sed -i "s/\s/\n/g" KEY1_VALUES.txt
sed -i "s/\s/\n/g" KEY2_VALUES.txt 

sed -i "/$(grep -f KEY2_VALUES.txt KEY1_VALUES.txt)/d" KEY2_VALUES.txt

sed -i "s/$(grep -w $KEY2 $FILE | cut -d "=" -f2)/$(cat KEY2_VALUES.txt | tr "\n" " ")/" $FILE

cat $FILE 
rm KEY1_VALUES.txt
rm KEY2_VALUES.txt 
