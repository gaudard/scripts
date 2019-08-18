import os
from time import sleep
binary = "~/vuln"
singlebuff = "A"
i = 5

while i < 40: 
    fuzzbuff = singlebuff * i
    os.system('echo "' + fuzzbuff + '" | ' + binary)
    i += 5
    sleep(1)
