#!/usr/bin/python
# Simple port scanner, version 2.0

print "[+] Starting port scanner...\n"
import socket


issubnet = input("If you wish to scan a subnet, enter 1: ")

if issubnet == 1:
	network = raw_input("Enter the network: ")
	hoststart = input("Enter the host start: ")
	hostend = input("Enter the host end: ")

	for host in range(hoststart, hostend):
		target = network + "." + str(host)
		print "\n[*] Scanning host {}.{}".format(network, host)
		print "[+] Scanning ports 1 through 1024\n"
		for port in range(1,1024):
			try:
				sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
				sock.settimeout(500)
				result = sock.connect_ex((target, port))
				if result == 0:
					print "Port {}: \t Open".format(port)
				sock.close
			except: continue		
	
else:
	target = raw_input("Enter a single ip or fqdn: ")
	print "[+] Scanning ports 1 through 1024\n"
	for port in range(1,1024):
		try:
			sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
			sock.settimeout(500)
			result = sock.connect_ex((target, port))
			if result == 0:
				print "Port {}: \t Open".format(port)
			sock.close
		except: continue






