#!/bin/bash -p

remove(){
	echo $1
	if [ -f "$log/$1" ]; then
		rm ${log}/${1}
	fi
}

spiro_and_arete(){
	echo "Raid Health"
	ssh root@$1 "/usr/local/bin/raid_health.sh && cat /tmp/smart_report.tmp" | awk '/SMART/{print $0}' >> ${log}/$1.txt

	printf "\n\n" >> ${log}/$1.txt
	echo "Top Processes"
	ssh root@$1 top >> ${log}/$1.txt
}
lys_buc_arist(){
	echo "Raid Health"
	ssh root@$1 "/usr/local/bin/cciss_vol_status /dev/cciss/c0d0 -V" >> ${log}/$1.txt
	printf "\n\n" >> ${log}/$1.txt
	echo "Top Processes"
	ssh root@$1 "top -n 1 -b|grep \"load average\" -A15" >> ${log}/$1.txt
}
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
if [ ! -d "${log}" ]; then
	mkdir -p $log
fi

if [ "${PHASE}" = "ALL" ] || [ "${PHASE}" = "spiro" ]; then

	remove spiro.txt

	printf " ----------\n Spiro\n ----------\n"
	printf "################\n" >> ${log}/spiro.txt
	printf "#	Spiro	     #\n" >> ${log}/spiro.txt
	printf "################\n" >> ${log}/spiro.txt
	printf "$(date)\n\n" >> ${log}/spiro.txt
	spiro_and_arete spiro

fi

if [ "${PHASE}" = "ALL" ] || [ "$PHASE" = "arete" ]; then

	remove arete.txt

	printf " ----------\n Arete\n ----------\n"
	printf "################\n" >> ${log}/arete.txt
	printf "#	Arete	     #\n" >> ${log}/arete.txt
	printf "################\n" >> ${log}/arete.txt
	printf "$(date)\n\n" >> ${log}/arete.txt

	spiro_and_arete arete

fi
if [ "${PHASE}" = "ALL" ] || [ "${PHASE}" = "lystrata" ]; then
		remove lystrata.txt
	printf "################\n" >> ${log}/lystrata.txt
	printf "#	Lystrata	#\n" >> ${log}/lystrata.txt
	printf "################\n" >> ${log}/lystrata.txt

	printf " ----------\n Lystrata\n ----------\n"
	printf "$(date)\n\n" >> ${log}/lystrata.txt

	lys_buc_arist lystrata

fi

if [ "${PHASE}" = "ALL" ] || [ "${PHASE}" = "bucephalus" ]; then
		remove bucephalus.txt
	printf "################\n" >> ${log}/bucephalus.txt
	printf "#	Bucephalus	#\n" >> ${log}/bucephalus.txt
	printf "################\n" >> ${log}/bucephalus.txt

	printf " ----------\n Bucephalus\n ----------\n"
	printf "$(date)\n\n" >> ${log}/bucephalus.txt
		lys_buc_arist bucephalus

fi

if [ "${PHASE}" = "ALL" ] || [ "${PHASE}" = "aristippus" ]; then
		remove aristippus.txt
	printf "################\n" >> ${log}/aristippus.txt
	printf "#	Aristippus	#\n" >> ${log}/aristippus.txt
	printf "################\n" >> ${log}/aristippus.txt

	printf " ----------\n Aristippus\n ----------\n"
	printf "$(date)\n\n" >> ${log}/aristippus.txt
		lys_buc_arist aristippus

fi

if [ "${PHASE}" = "ALL" ] || [ "${PHASE}" = "batty" ]; then
	remove batty.txt

	printf " ----------\n Batty\n ----------\n"
	printf "################\n" >> ${log}/batty.txt
	printf "#	Batty	     #\n" >> ${log}/batty.txt
	printf "################\n" >> ${log}/batty.txt
	printf "$(date)\n\n" >> ${log}/batty.txt

	echo "Raid health"
	ssh root@batty "tw_cli /c2 show" >> ${log}/batty.txt
	echo "Top processes"
	ssh root@batty "top -n 1 -b|grep \"load average\" -A15" >> ${log}/batty.txt


fi

if [ "${PHASE}" = "ALL" ] || [ "${PHASE}" = "morrison" ]; then
	remove morrison.txt

	printf " ----------\n Morrison\n ----------\n"
	printf "################\n" >> ${log}/morrison.txt
	printf "#	Morrison	     #\n" >> ${log}/morrison.txt
	printf "################\n" >> ${log}/morrison.txt
	printf "$(date)\n\n" >> ${log}/morrison.txt

	echo "Raid health"
	ssh root@morrison /opt/hp/hpssacli/bld/hpssacli ctrl all show config >> ${log}/morrison.txt

	echo "Top processes"
	ssh root@morrison "top -n 1 -b|grep \"load average\" -A15" >> ${log}/morrison.txt


fi


echo "All done :).  Logs are located in ${log}"
