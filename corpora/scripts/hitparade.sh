#!/bin/bash

#DEFAULTS
LNG=kaz

if [[ $1 != "" ]]; then
	#HP=$1
	LNG=`echo $1 | sed -r 's/^[\.\/]*([a-z][a-z][a-z])\.([^\.]*?)/\1/'`;
	CORP=`echo $1 | sed -r 's/^[\.\/]*([a-z][a-z][a-z])\.([^\.]*?)/\2/'`;
fi

#echo "$LNG BLAH $CORP";
HP=parade/$LNG.$CORP.hitparade.txt

DIX=$APERTIUMPATH/apertium-$LNG/apertium-$LNG.$LNG.lexc
BIN=$APERTIUMPATH/apertium-$LNG/$LNG.automorf.hfst


#cat $HP | sed -r 's/\s*[0-9]*//' | apertium-destxt | hfst-proc -w ~/quick/apertium/svn/incubator/apertium-tr-ky/ky-tr.automorf.hfst | apertium-retxt 
cat $HP | apertium-destxt | sed 's/[0-9]\+/[&]/1' | hfst-proc -w $BIN | apertium-retxt
