#!/bin/bash

PAIR=$2
#PAIR=kaz-tat
#PAIRREV=tat-kaz
LG1=`echo $PAIR | sed -r 's/([a-z]*)-([a-z]*)/\1/'`;
LG2=`echo $PAIR | sed -r 's/([a-z]*)-([a-z]*)/\2/'`;
PAIRREV=`echo $PAIR | sed -r 's/([a-z]*)-([a-z]*)/\2-\1/'`;
PAIRDIR=$APERTIUMPATH/incubator/apertium-$PAIR/

LNG=`echo $1 | sed -r 's/^[\.\/]*([a-z][a-z][a-z])\.([^\.]*?)\..*/\1/'`
CORP=`echo $1 | sed -r 's/^[\.\/]*([a-z][a-z][a-z])\.([^\.]*?)\..*/\2/'`
if [[ $LNG =~ $LG2 ]]; then
	PAIR=$PAIRREV
fi;

if [[ $1 =~ .*bz2 ]]; then
	CAT="bzcat"
else
	CAT="cat"
fi;


KNOWN=`$CAT $1 | apertium -d $PAIRDIR $PAIR-biltrans | sed 's/\$\W*\^/$\n^/g' | grep -v -e '@' -e '\*' | wc -l`
TOTAL=`$CAT $1 | apertium -d $PAIRDIR $PAIR-biltrans | sed 's/\$\W*\^/$\n^/g' | wc -l`
COV=`calc $KNOWN/$TOTAL`
DATE=`date`;

echo -e $LNG.$CORP \($PAIR trimmed\) $DATE"\t"$KNOWN"/"$TOTAL"\t"$COV >> history.log
tail -1 history.log
