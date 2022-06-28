#!/usr/bin/python3

import socket
import sys
import os

def help():
	print("Usage python3 pyports.py 192.168.1.1 -p 80")
	print("-p <port>        scan single port")
	print("-p-              scan 65537 ports")
	print("If you not specify -p or -p- it will scan common ports 20 21 22 80 443 8080\n")

os.system('rm -r "/tmp/portscan/" 2>/dev/null')
os.system('mkdir "/tmp/portscan/" 2>/dev/null')


if ( len(sys.argv) < 2 ):
	help()
	exit(1)

host=(sys.argv[1]);

portsfile="/tmp/portscan/" + "ports.log"
f = open(portsfile, "a")

f.write("Port scan against " + host + "\nSTATE   PORT\n")

print("Port scan against " + host)

def scan(host, port):
	s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	s.settimeout(0.01)
	try:
		s.connect((host, port))
		f.write("open    " + str(port) + "/tcp\n")
		f.close
		print("open    " + str(port) + "/tcp")
		s.close()
	except:
		s.close()


if ( len(sys.argv) < 3 ):
	print("STATE   PORT")
	for port in [ 20, 21, 22, 80, 443, 8080 ]:
		scan(host, port)
	exit(1)
elif ( sys.argv[2] == "-p-" ):
	print("STATE   PORT")
	for port in range(0, 65537):
		scan(host, port)
	exit(1)
elif ( sys.argv[2] == "-p" ):
	print("STATE   PORT")
	port = sys.argv[3]
	scan(host, int(port))
