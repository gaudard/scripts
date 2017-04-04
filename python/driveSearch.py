# This python script will search a host for a file or files, output results to a 
# text file, copy av logs, and compress all files.
# Created by @jgaudard
# Version 0.1


import subprocess
import os

#Variables
case = raw_input('Enter the case number for this incident\n:')
fileSearch = raw_input('Enter the file you are searching for\n(Note it is assumed to have * on each side of the file name you type)\n:')


#Drive Mapping
networkDriveL = raw_input("Enter the user's profile path\n:")
os.system(r'NET USE L: /delete')
os.system(r'NET USE L: %s' % networkDriveL)

#Log Creation
caseLog = open('%s.txt' % case, 'w')
caseLog.write('\n\nPreforming a search for %s on %s\n\n' % (fileSearch, networkDriveL))


#Searching
print('Preforming a search for %s on %s\n\n' % (fileSearch, networkDriveL))
search = subprocess.Popen(['l:', '&', 'cd\\', '&', 'chdir', '&', 'dir', '/s',  '*%s*' % fileSearch], stdout=caseLog, stderr=caseLog, shell=True)

search.wait()
caseLog.close()