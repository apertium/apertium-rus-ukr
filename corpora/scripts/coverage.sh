#!/bin/bash

LNG=`echo $1 | sed -r 's/^[\.\/]*([a-z][a-z][a-z])\.([^\.]*?)\..*/\1/'`
CORP=`echo $1 | sed -r 's/^[\.\/]*([a-z][a-z][a-z])\.([^\.]*?)\..*/\2/'`

#APERTIUMPATH=~/quick/apertium/svn
if [[ $APERTIUMPATH && ${APERTIUMPATH-x} ]]; then blah=0; else
	echo "APERTIUMPATH not set; please export APERTIUMPATH"
fi;

DIX=$APERTIUMPATH/apertium-$LNG/apertium-$LNG.$LNG.lexc
BIN=$APERTIUMPATH/apertium-$LNG/$LNG.automorf.hfst

if [[ $1 =~ .*bz2 ]]; then
	CAT="bzcat"
else
	CAT="cat"
fi;


$CAT $1 | apertium-destxt | hfst-proc -w $BIN | apertium-retxt | sed 's/\$\W*\^/$\n^/g' > /tmp/$LNG.$CORP.coverage.txt

EDICT=`cat $DIX | grep ' ; ' | grep -v '<' | grep '[АӘБВГҒДЕЁЖЗИІЙКҚЛМНҢОӨПРСТУҮҰФХҺЦЧШЩЪЫЬЭЮЯӐӖҪӲĔаәбвгғдеёжзиійкқлмнңоөпрстуүұфхһцчшщъыьэюяӑӗҫӳ]' | wc -l`;
EPAR=`cat $DIX | grep 'LEXICON ' | wc -l`;
TOTAL=`cat /tmp/$LNG.$CORP.coverage.txt | wc -l`
KNOWN=`cat /tmp/$LNG.$CORP.coverage.txt | grep -v '*' | wc -l`
COV=`calc $KNOWN / $TOTAL`;
DATE=`date`;

echo -e $LNG.$CORP $DATE"\t"$EPAR":"$EDICT"\t"$KNOWN"/"$TOTAL"\t"$COV >> history.log
tail -1 history.log
