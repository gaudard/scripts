#testing.py
# http://stackoverflow.com/questions/3921106/matching-popen-communicate-output-with-regular-expressions-doesnt-work



import subprocess


userid = raw_input("Enter the user's id\n:")

findUserProfile = subprocess.Popen(['NET','USER','/domain','%s' % userid], stdout=PIPE, stderr=PIPE, shell=True)

findUserProfile.wait()