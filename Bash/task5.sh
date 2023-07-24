#!/bin/bash

find . -type f -printf "%n %f\n" 2>/dev/null | sort -nr | cut -d " " -f 2 | head -n 5  
