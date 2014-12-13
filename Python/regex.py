#!/usr/bin/python

### Regex Testing ###

import re

print "[+] Starting"


f = open('permissions', 'r')
r = re.compile('S-\d-\d-\d+-\d+-\d+-\d+-\w+')

for line in f:
	if re.match('S-\d-\d-\d+-\d+-\d+-\d+-\w+', line):
		print line

f.close()


	

