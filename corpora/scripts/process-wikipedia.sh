#!/bin/bash

DUMP=$1
DIR=cv-ru
ROOT=/home/fran/source/apertium/incubator/apertium-cv-ru
ANALYSER=$ROOT"/"$DIR.automorf.hfst

if [ $# -lt 1 ]; then
	echo 'process-wikipedia.sh <dump file>'
	exit;
fi

bzcat $DUMP |\
grep '^[АаӘәБбВвГгҒғДдЕеЁёЖжЗзИиЙйКкҚқЛлМмНнҢңОоӨөПпРрСсТтУуҰұҮүФфҺһХхЦцЧчШшЩщъЫыІіьЭэЮюЯӐӖҪӲҢӨҮяӑӗҫӳңөү]' |\
grep -v 'File' |\
sed 's/&quot;/"/g' |\
sed 's/&gt;/>/g' |\
sed 's/&amp;gt;/>/g' |\
sed 's/&lt;/</g' |\
sed 's/&amp;lt;/</g' |\
sed 's/&amp;/\&/g' |\
sed 's/&nbsp;/ /g' |\
sed 's/&sup1;/¹/g' |\
sed 's/&sup2;/²/g' |\
sed 's/&sup3;/³/g' |\
sed 's/&ndash;/–/g' |\
sed "s/&alpha;/α/g" |sed "s/&beta;/β/g" |sed "s/&gamma;/γ/g" |sed "s/&delta;/δ/g" |sed "s/&epsilon;/ε/g" |sed "s/&zeta;/ζ/g" |sed "s/&eta;/η/g" |sed "s/&theta;/θ/g" |sed "s/&iota;/ι/g" |sed "s/&kappa;/κ/g" |sed "s/&lambda;/λ/g" |sed "s/&mu;/μ/g" |sed "s/&nu;/ν/g" |sed "s/&xi;/ξ/g" |sed "s/&omicron;/ο/g" |sed "s/&pi;/π/g" |sed "s/&rho;/ρ/g" |sed "s/&sigmaf;/ς/g" |sed "s/&sigma;/σ/g" |sed "s/&tau;/τ/g" |sed "s/&upsilon;/υ/g" |sed "s/&phi;/φ/g" |sed "s/&chi;/χ/g" |sed "s/&psi;/ψ/g" |sed "s/&omega;/ω/g" |\
sed "s/&Alpha;/Α/g" |sed "s/&Beta;/Β/g" |sed "s/&Gamma;/Γ/g" |sed "s/&Delta;/Δ/g" |sed "s/&Epsilon;/Ε/g" |sed "s/&Zeta;/Ζ/g" |sed "s/&Eta;/Η/g" |sed "s/&Theta;/Θ/g" |sed "s/&Iota;/Ι/g" |sed "s/&Kappa;/Κ/g" |sed "s/&Lambda;/Λ/g" |sed "s/&Mu;/Μ/g" |sed "s/&Nu;/Ν/g" |sed "s/&Xi;/Ξ/g" |sed "s/&Omicron;/Ο/g" |sed "s/&Pi;/Π/g" |sed "s/&Rho;/Ρ/g" |sed "s/&Sigma;/Σ/g" |sed "s/&Tau;/Τ/g" |sed "s/&Upsilon;/Υ/g" |sed "s/&Phi;/Φ/g" |sed "s/&Chi;/Χ/g" |sed "s/&Psi;/Ψ/g" |sed "s/&Omega;/Ω/g" |\
sed 's/{{mdash}}/—/g' |\
sed 's/{{citació necessària}}//g' |\
sed 's/{{cal citació}}//g' |\
sed 's/<nowiki>//g' | sed 's/<\/nowiki>//g' | sed 's/<br \?\/>//g' |\
sed 's/<\/\?\(text\|i\|b\|tt\|font\|gallery\|center\|small\|u\|p\|s\|SUB\|Sub\|big\|br\|cite\|code\|nowiki\|sub\|sup\|SUP\|Sup\|var\|BR\|em\|blockquote\)>//g' |\
sed 's/<\(sub\|sup\|SUP\|SUB\|Sup\|Sub\)\/>//g' | sed 's/<\/\(sub\|sup\) >//g' |\
sed "s/'''//g" |\
sed "s/''//g" |\
sed 's/<Br\/>/\n/g' |\
grep -vi -e '<ul><li>' -e '<.ref>' -e '< small>' -e ')#' -e '</ref>' -e '<ref' |\
grep -vi -e '</math>' -e '<math' |\
grep -v -e '<!--' -e '-->' |\
grep '\[\[.*|' |\
sed "s/\[\[[ \'0-9АаӘәБбВвГгҒғДдЕеЁёЖжЗзИиЙйКкҚқЛлМмНнҢңОоӨөПпРрСсТтУуҰұҮүФфҺһХхЦцЧчШшЩщъЫыІіьЭэЮюЯӐӖҪӲҢӨҮяӑӗҫӳңөү\-\(\)#·]\+|//g" |\
sed 's/\]\]//g' |\
sed 's/\[\[//g' |\
grep -v -e '|' -e '=' -e '://' |\
sed 's/$/./g' |\
apertium-destxt |\
hfst-proc $ANALYSER |\
apertium-retxt |\
sed 's/\^\.\/\.<sent>\$ \^[АБВГҒДЕӘЁЖЗИІЙКҚЛМНҢОӨПРСТУҮҰФХҺЦЧШЩЪЫЬЭЮЯӐӖҪӲҢӨҮ][абвгғдеәёжзиійкқлмнңоөпрстуүұфхһцчшщъыьэюяӑӗҫӳңөү]/^.\/.<sent>$\n&/g' |\
sed 's/\^\:\/\:<sent>\$ \^[АБВГҒДЕӘЁЖЗИІЙКҚЛМНҢОӨПРСТУҮҰФХҺЦЧШЩЪЫЬЭЮЯӐӖҪӲҢӨҮ][абвгғдеәёжзиійкқлмнңоөпрстуүұфхһцчшщъыьэюяӑӗҫӳңөү]/^:\/:<sent>$\n&/g' |\
sed 's/^\^\.\/\.<sent>\$ //g' |\
sed 's/^\^\:\/\:<sent>\$ //g' |\
python untag-corpus.py |\
sed 's/  */ /g' | sed 's/^ *//g' | sed 's/[0-9]\+ \. /&.NXNZ/g' | sed 's/ \. \.NXNZ/. /g' | sed 's/ , /, /g' | sed 's/ \. *$/./g' | sed 's/ : *$/:/g' |\
sed 's/ ( / (/g' | sed 's/ )/)/g'  |\
sed 's/  / /g'
