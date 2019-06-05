#!/bin/bash

PHASE=2

rm /tmp/caslog.txt
logfile="/tmp/caslog.txt"
echo $(date) >> $logfile
if [ ${PHASE} -eq 1 ]; then 
	printf "################" >> $logfile
	printf "#	Spiro	     #" >> $logfile
	printf "################" >> $logfile
	ssh root@spiro ssh root@spiro "/usr/local/bin/raid_health.sh && cat /tmp/smart_report.tmp" | awk '/SMART/{print $0}' >> /tmp/caslog.txt
fi 

if [ ${PHASE} -eq 2 ]; then
	printf "\n\n"

	printf "################\n" >> $logfile
	printf "#	Arete	     #\n" >> $logfile
	printf "################\n" >> $logfile

	ssh root@arete "/usr/local/bin/raid_health.sh && cat /tmp/smart_report.tmp" | awk '/SMART/{print $0}' >> /tmp/caslog.txt
fi
cat /tmp/caslog.txt
