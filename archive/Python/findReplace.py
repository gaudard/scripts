#!/usr/bin/python
# Find/Replace SID with username.

import re

print '[+] Doing things!'

### Opens files, sets variables
### REGEX for SIDs: S-\d-\d-\d+-\d+-\d+-\d+-\w+

sids = open("userAndSID.txt","r+")

'''
perms = open('permissions','r+')
newperms = open('updatedPermissions','w+')
'''

replacements = {}

### Adds user and sid from input file into replacements dictionary.
for line in sids:
	user, sid = line.split('\t')
	replacements.update({sid.rstrip():user.rstrip()})

with open('updatedPermissions','w+') as fout:
	with open('permissions','r+') as fin:
		for line in fin:
			print "[+] looking through the file"
			for key, value in replacements.iteritems():
				print "[+] now we are in the list of user and sids"
				fout.write(line.replace(key, value))



teststring = "D:AI(A;CIID;0x1200a9;;;S-1-5-21-1573582526-416615227-727307700-1009)(A;OICIIOID;FR;;;S-1-5-21-1573582526-416615227-727307700-1009)(A;OICIID;0x1301bf;;;S-1-5-21-1573582526-416615227-727307700-1010)(A;OICIID;FA;;;S-1-5-21-1573582526-416615227-727307700-1011)(A;OICIID;FR;;;S-1-5-21-1573582526-416615227-727307700-1012)(A;OICIID;FA;;;SY)(A;OICIID;FA;;;BA)(A;OICIID;0x1200a9;;;BU)(A;CIID;LC;;;BU)(A;CIID;DC;;;BU)(A;OICIIOID;GA;;;CO)"

r = re.findall('S-\d-\d-\d+-\d+-\d+-\d+-\w+', teststring)

print "[+] Found SID!! ", r






#### Closes files ####

sids.close()
fin.close()
fout.close()


#### Failed Code ####

'''
####
for line in perms:
	for ruser, rsid  in replacements.iteritems():
		line = line.replace(rsid, ruser)
	newperms.write(line)

####
indata = perms.read()
newperms.write(indata)

for aline in newperms:
	print aline

for line in sids:
	user, sid = line.split('\t')
	print user, sid

####
for line in perms:
	for src, target in replacements.iteritems():
		line = line.replace(src, target)
		print line
	newperms.write(line)

'''
