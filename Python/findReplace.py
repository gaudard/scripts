#!/usr/bin/python
# Find/Replace SID with username.


sids = open("userAndSID.txt","r")
perms = open('permissions','r')
newperms = open('updatedPermissions','w')

for line in sids:
	user, sid = line.split('\t')
	print "the user is: ", user
	print "the sid is: ", sid
	



#print perms.readlines()
