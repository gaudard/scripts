#This python script will check a host or hosts with a ping sweep.

import os

host = raw_input('Enter the hostname or ip address:\n\n')

doPing = os.system('ping -a %s' % host)

logFile = open('working.log', 'w')
logFile.write(doPing)
logFile.close()




