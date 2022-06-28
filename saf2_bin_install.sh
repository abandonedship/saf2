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

cp -r "$files_path"auto-gen-reverse-bind-tcp/shellstorm /usr/bin/
cp -r "$files_path"decoders/base32decode /usr/bin/
cp -r "$files_path"decoders/base64decode /usr/bin/
cp -r "$files_path"decoders/binarydecode /usr/bin/
cp -r "$files_path"decoders/decimaldecode /usr/bin/
cp -r "$files_path"decoders/hexadecode /usr/bin/
cp -r "$files_path"decoders/octaldecode /usr/bin/

cp -r "$files_path"encoders/base32encode /usr/bin/
cp -r "$files_path"encoders/base64encode /usr/bin/
cp -r "$files_path"encoders/binaryencode /usr/bin/
cp -r "$files_path"encoders/decimalencode /usr/bin/
cp -r "$files_path"encoders/hexaencode /usr/bin/
cp -r "$files_path"encoders/octalencode /usr/bin/

cp -r "$files_path"exploits/lfi2rce /usr/bin/
cp -r "$files_path"exploits/UnrealIrcd-3.2.8.1-cve-2010-2075-exploit.sh /usr/bin/

cp -r "$files_path"scanners/bports.sh /usr/bin/
cp -r "$files_path"scanners/lfisuite /usr/bin/
cp -r "$files_path"scanners/osd /usr/bin/
cp -r "$files_path"scanners/pingscan.sh /usr/bin/
cp -r "$files_path"scanners/pyports.py /usr/bin/
cp -r "$files_path"scanners/webspider /usr/bin/



cp -r "$files_path"stego/medusar /usr/bin/
cp -r "$files_path"webscrappers/gtfobins /usr/bin/

chmod +x /usr/bin/saf2

chmod +x /usr/bin/shellstorm

chmod +x /usr/bin/base32decode
chmod +x /usr/bin/base64decode
chmod +x /usr/bin/binarydecode
chmod +x /usr/bin/decimaldecode
chmod +x /usr/bin/hexadecode
chmod +x /usr/bin/octaldecode


chmod +x /usr/bin/base32encode
chmod +x /usr/bin/base64encode
chmod +x /usr/bin/binaryencode
chmod +x /usr/bin/decimalencode
chmod +x /usr/bin/hexaencode
chmod +x /usr/bin/octalencode

chmod +x /usr/bin/lfi2rce
chmod +x /usr/bin/UnrealIrcd-3.2.8.1-cve-2010-2075-exploit.sh

chmod +x /usr/bin/bports.sh
chmod +x /usr/bin/lfisuite
chmod +x /usr/bin/osd
chmod +x /usr/bin/pingscan.sh
chmod +x /usr/bin/pyports.py
chmod +x /usr/bin/webspider

chmod +x /usr/bin/medusar
chmod +x /usr/bin/gtfobins



###

chmod -R +x /opt/saf2/tools/auto-gen-reverse-bind-tcp
chmod -R +x /opt/saf2/tools/decoders
chmod -R +x /opt/saf2/tools/encoders
chmod -R +x /opt/saf2/tools/exploits
chmod -R +x /opt/saf2/tools/scanners
chmod -R +x /opt/saf2/tools/stego
chmod -R +x /opt/saf2/tools/webscrappers

###


printf "%s\n" "Done."
