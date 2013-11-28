TMPDIR=/tmp
LANG1=../../../../languages/apertium-ukr/

DIR=$1

if [[ $DIR = "ukr-rus" ]]; then

lt-expand $LANG1/apertium-ukr.ukr.dix | grep -v '<prn><enc>' | grep -v 'REGEX' | grep -v ':<:' | sed 's/:>:/%/g' | sed 's/:/%/g' | cut -f2 -d'%' |  sed 's/^/^/g' | sed 's/$/$ ^.<sent>$/g' | tee $TMPDIR/$DIR.tmp_testvoc1.txt |
        apertium-pretransfer|
	lt-proc -b ../../ukr-rus.autobil.bin |  tee $TMPDIR/$DIR.tmp_testvoc2.txt |
        lrx-proc ../../ukr-rus.autolex.bin |
        apertium-transfer -b ../../apertium-rus-ukr.ukr-rus.t1x  ../../ukr-rus.t1x.bin |
        apertium-interchunk ../../apertium-rus-ukr.ukr-rus.t2x  ../../ukr-rus.t2x.bin |
        apertium-postchunk ../../apertium-rus-ukr.ukr-rus.t3x  ../../ukr-rus.t3x.bin  | tee $TMPDIR/$DIR.tmp_testvoc3.txt |
        lt-proc -d ../../ukr-rus.autogen.bin > $TMPDIR/$DIR.tmp_testvoc4.txt
paste -d _ $TMPDIR/$DIR.tmp_testvoc1.txt $TMPDIR/$DIR.tmp_testvoc2.txt $TMPDIR/$DIR.tmp_testvoc3.txt $TMPDIR/$DIR.tmp_testvoc4.txt | sed 's/\^.<sent>\$//g' | sed 's/_/   --------->  /g'

elif [[ $DIR = "rus-ukr" ]]; then

lt-expand ../../apertium-rus-ukr.rus.dix | grep -v '<prn><enc>' | grep -v 'REGEX' | grep -v ':<:' | sed 's/:>:/%/g' | sed 's/:/%/g' | cut -f2 -d'%' |  sed 's/^/^/g' | sed 's/$/$ ^.<sent>$/g' | tee $TMPDIR/$DIR.tmp_testvoc1.txt |
        apertium-pretransfer|
	lt-proc -b ../../rus-ukr.autobil.bin | tee $TMPDIR/$DIR.tmp_testvoc2.txt |
        lrx-proc ../../rus-ukr.autolex.bin |
        apertium-transfer -b ../../apertium-rus-ukr.rus-ukr.t1x  ../../rus-ukr.t1x.bin |
        apertium-interchunk ../../apertium-rus-ukr.rus-ukr.t2x  ../../rus-ukr.t2x.bin |
        apertium-postchunk ../../apertium-rus-ukr.rus-ukr.t3x  ../../rus-ukr.t3x.bin  | tee $TMPDIR/$DIR.tmp_testvoc3.txt |
        lt-proc -d ../../rus-ukr.autogen.bin > $TMPDIR/$DIR.tmp_testvoc4.txt
paste -d _ $TMPDIR/$DIR.tmp_testvoc1.txt $TMPDIR/$DIR.tmp_testvoc2.txt $TMPDIR/$DIR.tmp_testvoc3.txt $TMPDIR/$DIR.tmp_testvoc4.txt| sed 's/\^.<sent>\$//g' | sed 's/_/   --------->  /g'


else
	echo "bash inconsistency.sh <direction>";
fi
