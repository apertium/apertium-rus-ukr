#!/bin/bash

#DEFAULTS
#LNG=kaz
PAIR=rus-ukr
SL=ukr
TL=rus
CORP=rferl
APERTIUMPATH=/home/kirill/Desktop/Dropbox

#if [[ $1 != "" ]]; then
	#HP=$1
	#LNG=`echo $1 | sed -r 's/^[\.\/]*([a-z][a-z][a-z])\.([^\.]*?)/\1/'`;
	#CORP=`echo $1 | sed -r 's/^[\.\/]*([a-z][a-z][a-z])\.([^\.]*?)/\2/'`;
#fi

#echo "$LNG BLAH $CORP";
HP=parade/$SL.$CORP.hitparade.txt

DIX=$APERTIUMPATH/apertium-$PAIR/apertium-$PAIR.$SL.dix
BIN=$APERTIUMPATH/apertium-$PAIR/$SL-$TL.automorf.bin


#cat $HP | sed -r 's/[0-9]\+/[&]/1' | apertium-destxt | hfst-proc -w ~/quick/apertium/svn/incubator/apertium-tr-ky/ky-tr.automorf.hfst | apertium-retxt 
cat $HP | apertium-destxt | sed 's/\s*[0-9]*//' | lt-proc -w $BIN | apertium-retxt
