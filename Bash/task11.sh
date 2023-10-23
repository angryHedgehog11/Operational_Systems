#!/bin/bash 

inode=$(find ~velin/ -type f -printf '%T@ %i\n' 2>/dev/null | sort -nr | head -n 1 | cut -d ' ' -f 2)
echo $(find ~velin/ -type f -inum $inode -printf "%d %f\n" 2>/dev/null | sort -nr | head -n 1)
