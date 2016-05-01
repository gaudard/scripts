#!/usr/bin/python
#!C:\Python27\python.exe

# pslist/fport differences

import csv
from collections import defaultdict

print("\n\n[*] Starting...\n\n")

fport = "/Users/gaudard/Desktop/code/txts/fport.txt"  # column 5
pslist = "/Users/gaudard/Desktop/code/txts/pslist.txt" # column 0
columns = defaultdict(list)

def readFiles(infile):
	with open(infile) as f:
		reader = csv.reader(f, delimiter=" ")
		reader.next()
		for row in reader:
			for (i,v) in enumerate(row):
				columns[i].append(v)
	return columns

readFiles(pslist)
print "\nprinting pslist\n"
print columns[0]


readFiles(fport)
print "\nprinting fport listing\n"
print columns[5]



