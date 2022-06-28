#!/bin/bash

if [ -z "$1" ]
then
	printf -- "Usage example:\n"
	printf -- "bash pingscan.sh 192.168.1.1-200            scan from 192.168.1.1 to 192.168.1.200\n"
        printf -- "bash pingscan.sh 192.168.1.1/24             scan from 192.168.1.1 to 192.168.1.254\n"
	printf -- "bash pingscan.sh 192.168.1.1/24 --fast      to faster scan(not recommended maybe some hosts will not be discovered)\n"
	exit
fi


function output_proc_net_arp(){

        printf "%s\n" "Additional arp information"
        printf "%s\n" "-------------------ARP TABLE------------------------"
        arp_table_output=$(grep '0x2' /proc/net/arp | sed 's/0x1//g' | sed 's/0x2//g' | sed 's/*//g' | sed 's/eth.*//g' | sed 's/wlan.*//g' | sort)
        printf "$arp_table_output"
        printf "\n%s\n\n" "----------------------------------------------------"
}




result="/tmp/pingresult"
rm -r "$result" 2>/dev/null

full_range_scan="/"
custom_range_scan="-"

timeout="0.4"
if [ "$2" == "--fast" ]
then
	timeout="0.01"
fi


############# Single host scan
if [[ "$1" != *"$full_range_scan"* ]] || [[ "$1" != *"$custom_range_scan"* ]];
then
	status=$(ping -c 1 -s 1 -w 0 -W "$timeout" "$1" 2>/dev/null | grep -o ttl)
	if [ "$status" == "ttl" ]
        then
                printf "[\e[0;32m+\e[0m] $1 is up\n" > "$result"

		printf "\n"
	        cat "$result" 2>/dev/null
       		printf "\n"
	        output_proc_net_arp
	fi


fi
########################################


#### Custom range scan
if [[ "$1" == *"$custom_range_scan"* ]];
then
        counter=$(printf -- "$1" | awk -F "." '{print $4}' | awk -F "-" '{print $1}')

        total_to_scan=$(printf -- "$1" | awk -F "-" '{print $2}')

	arg_ip="$1"
        baking_ip=$(echo "${arg_ip%.*}")
        baked=$(printf -- "$baking_ip.")

	count="$counter"
        printf "Scanning $1\n"

	while [ $count -le $total_to_scan ];
        do
                printf "[\e[0;33m*\e[0m] Sending ping to $baked$count\n"
		status=$(ping -c 1 -s 1 -w 0 -W "$timeout" "$baked$count" 2>/dev/null | grep -o ttl)

		if [ "$status" == "ttl" ]
	        then
        	        printf "[\e[0;32m+\e[0m] $baked$count is up\n" >> "$result"
		fi

                let count=count+1
        done

	printf "\n"
	cat "$result" 2>/dev/null
	printf "\n"
	output_proc_net_arp

fi


##### Full range scan
if [[ "$1" == *"$full_range_scan"* ]];
then
        arg_ip="$1"
        baking_ip=$(echo "${arg_ip%.*}")
        baked=$(printf -- "$baking_ip.")

        hosts_to_scan=$(printf -- "$1" | awk -F"/" '{print $2}')
        if [ "$hosts_to_scan" == "24" ];
        then
                printf -- "Scanning whole network 254 hosts\n"

                count=0
                while [ $count -le 254 ];
                do
                        printf "[\e[0;33m*\e[0m] Sending ping to $baked$count\n"
                        status=$(ping -c 1 -s 1 -w 0 -W "$timeout" "$baked$count" 2>/dev/null | grep -o ttl)

			if [ "$status" == "ttl" ]
	                then
        	                printf "[\e[0;32m+\e[0m] $baked$count is up\n" >> "$result"
			fi

                        let count=count+1
                done

		printf "\n"
		cat "$result" 2>/dev/null
		printf "\n"
		output_proc_net_arp

        else
                printf -- "That value isnt /24\nis the only allowed at the moment and corresponds to 254 hosts\n"
                exit
        fi


fi
