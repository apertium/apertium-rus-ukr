if [[ $1 = "1" ]]; then
echo "==Ukrainian->Russian===========================";
bash inconsistency.sh ukr-rus > /tmp/ukr-rus.testvoc; bash inconsistency-summary.sh /tmp/ukr-rus.testvoc ukr-rus
echo ""

elif [[ $1 = "2" ]]; then
echo "==Russian->Ukrainian===========================";
bash inconsistency.sh rus-ukr > /tmp/rus-ukr.testvoc; bash inconsistency-summary.sh /tmp/rus-ukr.testvoc rus-ukr

fi
