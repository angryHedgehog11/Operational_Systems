#!/bin/bash 

echo "The number of searched rows is: $(egrep '[02468]+' philip-j-fry.txt | egrep -v '[a-w]' | wc -l)"
