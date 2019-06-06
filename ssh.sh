#!/bin/bash -p

PHASE="ALL"
	while getopts ":a:" opt; do
		case $opt in
			a)
				PHASE=${OPTARG}
				;;
		esac
	done
shift $((OPTIND -1))

echo $PHASE
log=$(pwd)/log

if [ "${PHASE}" = "ALL" ] || [ "${PHASE}" = "spiro" ]; then
	if [ -f ${log}/spiro.txt ]; then
		rm ${log}/spiro.txt
	fi
	printf " ----------\n Spiro\n ----------\n"
	printf "################\n" >> ${log}/spiro.txt
	printf "#	Spiro	     #\n" >> ${log}/spiro.txt
	printf "################\n" >> ${log}/spiro.txt
	printf "$(date)\n\n" >> ${log}/spiro.txt
	echo "Raid Health"
	ssh root@spiro "/usr/local/bin/raid_health.sh && cat /tmp/smart_report.tmp" | awk '/SMART/{print $0}' >> ${log}/spiro.txt

	printf "\n\n" >> ${log}/spiro.txt
	echo "Top Processes"
	ssh root@spiro top >> ${log}/spiro.txt
fi

if [ "${PHASE}" = "ALL" ] || [ "$PHASE" = "arete" ]; then
	if [ -f ${log}/arete.txt ]; then
		rm ${log}/arete.txt
	fi
	printf " ----------\n Arete\n ----------\n"
	printf "################\n" >> ${log}/arete.txt
	printf "#	Arete	     #\n" >> ${log}/arete.txt
	printf "################\n" >> ${log}/arete.txt
	printf "$(date)\n\n" >> ${log}/arete.txt
	echo "Raid Health"
	ssh root@arete "/usr/local/bin/raid_health.sh && cat /tmp/smart_report.tmp" | awk '/SMART/{print $0}' >> ${log}/arete.txt
	printf "\n\n" >> ${log}/arete.txt
	echo "Top Processes" 
	ssh root@arete top >> ${log}/arete.txt
	# cat ${log}/arete.txt
fi
if [ "${PHASE}" = "ALL" ] || [ "${PHASE}" = "lystrata" ]; then
	if [ "$(ls -A $log/lystrata.txt)" ]; then
		rm ${log}/lystrata.txt
	fi
	printf "################\n" >> ${log}/lystrata.txt
	printf "#	Lystrata	#\n" >> ${log}/lystrata.txt
	printf "################\n" >> ${log}/lystrata.txt

	printf " ----------\n Lystrata\n ----------\n"
	printf "$(date)\n\n" >> ${log}/lystrata.txt
	echo "Raid Health"
	ssh root@lystrata "/usr/local/bin/cciss_vol_status /dev/cciss/c0d0 -V" >> ${log}/lystrata.txt
	printf "\n\n" >> ${log}/lystrata.txt
	echo "Top Processes"
	ssh root@lystrata "top -n 1 -b|grep \"load average\" -A15" >> ${log}/lystrata.txt

fi
echo "All done :).  Logs are located in ${log}/log"