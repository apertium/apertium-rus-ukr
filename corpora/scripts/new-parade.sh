#!/bin/bash

cat /tmp/$1.coverage.txt | cut -f2 -d'^' | cut -f1 -d'/' | sort -f | uniq -c | sort -gr  | grep -v '[0-9] [0-9]' > parade/$1.hitparade.txt 
