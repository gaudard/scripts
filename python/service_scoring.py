#!/usr/bin/python3

import subprocess, shlex, random, re, time shutil

targets = ["192.168.10.101","192.168.10.102","192.168.10.103"]
ports = ["21","22","23","445"]
scores = {"192.168.10.101":0,"192.168.10.102":0,"192.168.10.103":0}
scoreFile = "/root/scores.txt"

def scanner(ip, port)
  cmd = "/usr/bin/nmap -n --max-retries 0 -T4 -sV -p" + port + " -Pn -oG - " + ip
  args = shlex.split(cmd)
  scan = subprocess.check_output(args)
  return scan.decode('utf-8')
  
while True:
  startTime = time.time()
  random.shuffle(targets)
  random.shuffle(ports)
  #print(scores)
  random.shuffle(targets)
  for port in ports:
    for target in targets:
      if "open" in scanner(target, port):
        scores[target] += 2
      else:
        scores[target] -= 10
  endTime = time.time()
  with open(scoreFile, 'w') as outfile:
    for target in scores:
      line = target, scores[target]
      outfile.write(re.sub("[()',]", '', str(line)))
      outfile.write('\n')
  shutil.copy(scoreFile, '/var/www/html/scores.txt')
  print("Scores updated. Run time: ", endTime - startTime)
  time.sleep(900)
