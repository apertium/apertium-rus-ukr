#!/bin/bash

#DEFAULTS
LNG=kaz

if [[ $1 != "" ]]; then
	#HP=$1
	LNG=`echo $1 | sed -r 's/^[\.\/]*([a-z][a-z][a-z])\.([^\.]*?).*/\1/'`;
	CORP=`echo $1 | sed -r 's/^[\.\/]*([a-z][a-z][a-z])\.([^\.]*?).*/\2/'`;
fi

if [[ $1 =~ .*bz2 ]]; then
	CAT="bzcat"
else
	CAT="cat"
fi;

echo "$LNG BLAH $CORP";
HP=parade/$LNG.$CORP.hitparade.txt
FREQ=parade/$LNG.$CORP.morphfreq.txt

DIX=~/quick/apertium/GSoC12/apertium-$LNG/apertium-$LNG.$LNG.lexc
BIN=~/quick/apertium/GSoC12/apertium-$LNG/$LNG.automorf.hfst
RLX=~/quick/apertium/GSoC12/apertium-$LNG/$LNG.rlx.bin
SLOW=~/quick/apertium/GSoC12/apertium-$LNG/.deps/$LNG.RL.lexc.hfst
FAST=/tmp/$LNG-fast.hfst

hfst-fst2fst -O -i $SLOW -o $FAST

$CAT $1 | hfst-proc -w $BIN  | cg-proc -n -1 $RLX | apertium-pretransfer | sed 's/\$\W*\^/$\n^/g' | sed 's/\s/\n/g' | hfst-proc -g $FAST | sed 's/>/\n/g' | cut -f1 -d'/' | sort -f | uniq -c | sort -gr > $FREQ
