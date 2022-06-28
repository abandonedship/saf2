#!/bin/bash

# Simple bash port scanner

host="$1"
port="$2"
timeout="0.4"
header="Simple bash port scanner\n"
if [ -z "$1" ] || [ -z "$2" ]
then
	printf "Usage bash bports.sh 78.30.20.1 80\n"
	exit
fi

printf "$header\nScanning $host $port\n"
timeout "$timeout" bash -c "echo >/dev/tcp/$host/$port" 2>/dev/null &&
printf "\e[0;32mopen\e[0m $port/tcp\n" ||
printf "\e[1;31mclosed\e[0m $port/tcp\n"
