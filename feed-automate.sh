#!/bin/bash
figlet -r -f big "Threat Intel"
figlet -r -f big "Feed Automater"
echo " "
echo " "
echo "                             v-0.1"
CURRENTDATE=`date +"%Y-%m-%d %T"`
echo " "
echo " "
echo " Downloading Feed for the date" ${CURRENTDATE}
sleep 3
echo " "
echo " "
wget -c -A txt -q --show-progress --progress=bar:force 2>&1 -i ioc.list
echo " "
for file in *.*; do
 mv -- "${file}" "`basename -- "${file}"`.txt"
done
mv ioc.list.txt ioc.list
mv feed-automate.sh.txt feed-automate.sh
#mv domains.sh.txt domains.sh
sleep 5
echo "Extracting Malicious IP Addresses"
sed -n 's/\([0-9]\{1,3\}\.\)\{3\}[0-9]\{1,3\}/\nip&\n/gp' *.txt | grep ip | sed 's/ip//'| sort | uniq >  "Malicious-IP's-`date '+%Y-%m-%d-%T'`.csv"
cat *.txt > domains.txt
echo " "
echo " "
echo "Extracting Malicious Domains"
grep -oP '[^\./]*\.[^\./]*(:|/)' domains.txt | sed -e 's/\(:.*\/\|\/\)//g' | cut -f1 | sort | uniq > "Malicious-Domain's-`date '+%Y-%m-%d-%T'`.csv"
rm -rf *.txt
for x in *.csv; do mv "$x" "${x%.csv}.txt"; done
echo " "
echo " "
echo "Total Number of Maliocus IP's Found today:"  
wc -l < Malicious-IP*
echo " "
echo " "
echo "Total Number of Maliocus Domain's Found today:"
wc -l < Malicious-Doma*
sleep 2
echo " "
echo " "
echo "Cleaning Temporary Files ....!!!"
echo " "
echo " "
sleep 3
exit