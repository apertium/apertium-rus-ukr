#!/bin/bash

#CORP=$1
bash new-parade.sh $1
#bash hitparade.sh parade/$1.hitparade.txt > parade/$1.hitparade2.txt
bash hitparade.sh $1 > parade/$1.hitparade2.txt
grep '\*.*' parade/$1.hitparade2.txt > parade/$1.top150.txt
