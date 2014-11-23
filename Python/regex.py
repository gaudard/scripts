#!/usr/bin/python

### Regex Testing ###

import re

print "[+] Starting"


teststring = "D:AI(A;CIID;0x1200a9;;;S-1-5-21-1573582526-416615227-727307700-1009)(A;OICIIOID;FR;;;S-1-5-21-1573582526-416615227-727307700-1009)(A;OICIID;0x1301bf;;;S-1-5-21-1573582526-416615227-727307700-1010)(A;OICIID;FA;;;S-1-5-21-1573582526-416615227-727307700-1011)(A;OICIID;FR;;;S-1-5-21-1573582526-416615227-727307700-1012)(A;OICIID;FA;;;SY)(A;OICIID;FA;;;BA)(A;OICIID;0x1200a9;;;BU)(A;CIID;LC;;;BU)(A;CIID;DC;;;BU)(A;OICIIOID;GA;;;CO)"


'''
with open(f, 'r') as f:
	lines = f.readlines()
'''


r = re.findall('S-\d-\d-\d+-\d+-\d+-\d+-\w+', teststring)



print "[+] Found SID!! ", r
	

	

