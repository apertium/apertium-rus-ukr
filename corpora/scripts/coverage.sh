#!/bin/bash

PAIR=rus-ukr
SL=ukr #`echo $1 | sed -r 's/^[\.\/]*([a-z][a-z][a-z])\.([^\.]*?)\..*/\1/'`
TL=rus
CORP=rferl #`echo $1 | sed -r 's/^[\.\/]*([a-z][a-z][a-z])\.([^\.]*?)\..*/\2/'`

APERTIUMPATH=/home/kirill/Desktop/Dropbox
if [[ $APERTIUMPATH && ${APERTIUMPATH-x} ]]; then blah=0; else
	echo "APERTIUMPATH not set; please export APERTIUMPATH"
fi;

DIX=$APERTIUMPATH/apertium-$PAIR/apertium-$PAIR.$SL.dix
BIN=$APERTIUMPATH/apertium-$PAIR/$SL-$TL.automorf.bin

if [[ $1 =~ .*bz2 ]]; then
	CAT="bzcat"
else
	CAT="cat"
fi;


$CAT $1 | apertium-destxt | lt-proc -w $BIN | apertium-retxt | sed 's/\$\W*\^/$\n^/g' > /tmp/$SL.$CORP.coverage.txt

EDICT=`cat $DIX | grep '<e lm' | wc -l`;
EPAR=`cat $DIX | grep '<pardef n' | wc -l`;
TOTAL=`cat /tmp/$SL.$CORP.coverage.txt | wc -l`
KNOWN=`cat /tmp/$SL.$CORP.coverage.txt | grep -v '*' | wc -l`
COV=`calc $KNOWN / $TOTAL`;
DATE=`date`;

echo -e $SL.$CORP $DATE"\t"$EPAR":"$EDICT"\t"$KNOWN"/"$TOTAL"\t"$COV >> history.log
tail -1 history.log
