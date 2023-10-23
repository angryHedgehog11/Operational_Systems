#!/bin/bash

find $(cat /ect/passwd | egrep ^$(whoami) | cut -d ':' -f 6) -maxdepth 1 -type f -user $(whoami) 2>/dev/null | xargs chmod 664
