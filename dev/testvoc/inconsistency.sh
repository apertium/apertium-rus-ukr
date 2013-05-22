TMPDIR=/tmp

DIR=$1

if [[ $DIR = "ukr-rus" ]]; then

lt-expand ../../apertium-ru-uk.uk.dix | grep -v '<prn><enc>' | grep -v 'REGEX' | grep -v ':<:' | sed 's/:>:/%/g' | sed 's/:/%/g' | cut -f2 -d'%' |  sed 's/^/^/g' | sed 's/$/$ ^.<sent>$/g' | tee $TMPDIR/$DIR.tmp_testvoc1.txt |
        apertium-pretransfer|
	lt-proc -b ../../uk-ru.autobil.bin |  tee $TMPDIR/$DIR.tmp_testvoc2.txt |
        apertium-transfer -b ../../apertium-ru-uk.uk-ru.t1x  ../../uk-ru.t1x.bin |
        apertium-interchunk ../../apertium-ru-uk.uk-ru.t2x  ../../uk-ru.t2x.bin |
        apertium-postchunk ../../apertium-ru-uk.uk-ru.t3x  ../../uk-ru.t3x.bin  | tee $TMPDIR/$DIR.tmp_testvoc3.txt |
        lt-proc -d ../../uk-ru.autogen.bin > $TMPDIR/$DIR.tmp_testvoc4.txt
paste -d _ $TMPDIR/$DIR.tmp_testvoc1.txt $TMPDIR/$DIR.tmp_testvoc2.txt $TMPDIR/$DIR.tmp_testvoc3.txt $TMPDIR/$DIR.tmp_testvoc4.txt | sed 's/\^.<sent>\$//g' | sed 's/_/   --------->  /g'

elif [[ $DIR = "rus-ukr" ]]; then

lt-expand ../../apertium-ru-uk.ru.dix | grep -v '<prn><enc>' | grep -v 'REGEX' | grep -v ':<:' | sed 's/:>:/%/g' | sed 's/:/%/g' | cut -f2 -d'%' |  sed 's/^/^/g' | sed 's/$/$ ^.<sent>$/g' | tee $TMPDIR/$DIR.tmp_testvoc1.txt |
        apertium-pretransfer|
	lt-proc -b ../../ru-uk.autobil.bin | tee $TMPDIR/$DIR.tmp_testvoc2.txt |
        apertium-transfer -b ../../apertium-ru-uk.ru-uk.t1x  ../../ru-uk.t1x.bin |
        apertium-interchunk ../../apertium-ru-uk.ru-uk.t2x  ../../ru-uk.t2x.bin |
        apertium-postchunk ../../apertium-ru-uk.ru-uk.t3x  ../../ru-uk.t3x.bin  | tee $TMPDIR/$DIR.tmp_testvoc3.txt |
        lt-proc -d ../../ru-uk.autogen.bin > $TMPDIR/$DIR.tmp_testvoc4.txt
paste -d _ $TMPDIR/$DIR.tmp_testvoc1.txt $TMPDIR/$DIR.tmp_testvoc2.txt $TMPDIR/$DIR.tmp_testvoc3.txt $TMPDIR/$DIR.tmp_testvoc4.txt| sed 's/\^.<sent>\$//g' | sed 's/_/   --------->  /g'


else
	echo "bash inconsistency.sh <direction>";
fi
