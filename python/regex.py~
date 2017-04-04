#!/usr/bin/python

### Regex Testing ###

import re

print "[+] Starting"

f = 'permissions'



with open(f, 'r') as f:
	lines = f.read()

for line in lines:
	r = re.search(r'temp\different\users', line)
	if r:
		new_line=r.group() + '\n'
		print new_line
	



f.close()
