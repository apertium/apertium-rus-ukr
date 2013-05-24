#!/bin/bash

#DEFAULTS
LNG=kaz-tat

if [[ $1 != "" ]]; then
	#HP=$1
	LNG=`echo $1 | sed -r 's/^[\.\/]*([a-z][a-z][a-z]-[a-z][a-z][a-z])\.([^\.]*?)/\1/'`;
	LNG1=`echo $1 | sed -r 's/^[\.\/]*([a-z][a-z][a-z])-[a-z][a-z][a-z]\.([^\.]*?)/\1/'`;
	CORP=`echo $1 | sed -r 's/^[\.\/]*([a-z][a-z][a-z]-[a-z][a-z][a-z])\.([^\.]*?)/\2/'`;
fi

if [[ $LNG=="tat-kaz" ]]; then
	# for Tatar analysis
	PAIR="kaz-tat";
else	
	PAIR=$LNG;
fi

echo "$1 : $LNG BLAH $CORP : $PAIR";
HP=parade/$LNG.$CORP.hitparade.txt

DIX=$APERTIUMPATH/staging/apertium-$PAIR/apertium-$PAIR.$LNG.lexc
BIN=$APERTIUMPATH/staging/apertium-$PAIR/$LNG.automorf.hfst
BIN1=$APERTIUMPATH/incubator/apertium-$LNG1/$LNG1.automorf.hfst

#cat $HP | sed -r 's/\s*[0-9]*//' | apertium-destxt | hfst-proc -w ~/quick/apertium/svn/incubator/apertium-tr-ky/ky-tr.automorf.hfst | apertium-retxt 
cat $HP | apertium-destxt | sed 's/[0-9]\+/[&]/1' | hfst-proc -w $BIN | apertium-retxt > parade/$1.hitparade2.txt

grep '\*.*' parade/$1.hitparade2.txt > parade/$1.top150.txt

#cat parade/$1.top150.txt | apertium-destxt | hfst-proc $BIN | apertium-retxt | grep '\*' | cut -f2 -d'^' | cut -f1 -d'/' > parade/$1.unk.txt
#cat parade/$1.unk.txt | hfst-proc $BIN1 | grep -v '\*' > parade/$1.kno.txt
cat parade/$1.top150.txt | sed -r 's/.*\^(.*)\/.*/\1/' | apertium-destxt | hfst-proc $BIN1 | apertium-retxt | grep -v '\*' > parade/$1.kno.txt
