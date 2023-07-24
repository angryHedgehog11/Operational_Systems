#!/bin/bash


echo "Number of objects: $(find / -user $(whoami) 2>/dev/null | wc -l)"
