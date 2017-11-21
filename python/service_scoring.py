#!/usr/bin/python3

import subprocess, shlex, random

targets = ["192.168.10.101","192.168.10.102","192.168.10.103"]
ports = ["21","22","23","445"]
scores = {"192.168.10.101":0,"192.168.10.102":0,"192.168.10.103":0}

def scanner(ip, port)
  cmd = "/usr/bin/nmap -n -sV -p" + port + " -Pn -oG - " + ip
  args = shlex.split(cmd)
  scan = subprocess.check_output(args)
  return scan.decode('utf-8')
  
while True:
  print(scores)
  random.shuffle(targets)
  for port in ports:
    for target in targets:
      if "open" in scanner(target, port):
        scores[target] += 1
