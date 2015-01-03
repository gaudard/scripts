#!/usr/bin/python
# Simple port scanner, version 1.0
# Source code: http://www.pythonforbeginners.com/code-snippets-source-code/port-scanner-in-python


host='74.207.244.221' # scanme.nmap.org

import socket

for port in range(10,100):
	try:
		sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
		sock.settimeout(1)
		result = sock.connect_ex((host, port))
		if result == 0:
			print "Port {}: \t Open".format(port)
		sock.close
	except: continue

