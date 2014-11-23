#!/usr/bin/python
# Find/Replace SID with username.

import re

print '[+] Doing things!'

### Opens files, sets variables

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
