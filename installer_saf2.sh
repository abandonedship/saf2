#!/bin/bash

if [ $(id -u) != "0" ]
then
        printf "Run me as root\n"
        exit
fi

files_path="$PWD/tools/"

rm -r /opt/saf2/ 2>/dev/null
mkdir /opt/saf2

cp -r "$files_path" /opt/saf2/
cp -r "$files_path"../saf2 /usr/bin/

chmod +x /usr/bin/saf2

chmod -R +x /opt/saf2/tools/auto-gen-reverse-bind-tcp
chmod -R +x /opt/saf2/tools/decoders
chmod -R +x /opt/saf2/tools/encoders
chmod -R +x /opt/saf2/tools/exploits
chmod -R +x /opt/saf2/tools/scanners
chmod -R +x /opt/saf2/tools/stego
chmod -R +x /opt/saf2/tools/webscrappers

printf "%s\n" "Done."
