#!/bin/bash

find . -type f -printf "%f %n\n" 2>/dev/null | sort -k 2 -nr | cut -d " " -f 2 | head -n 5  
