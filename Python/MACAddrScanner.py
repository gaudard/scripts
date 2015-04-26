###################################################
#
# Code from: http://edwardkeeble.com/2014/02/passive-wifi-tracking/
# Modified by @jgaudard started on 24 April 2015
#
# Scans for MACs that are not in the whitelist
# then prints them to the screen including MAC,
# SSID, Signal Strength after searching csv.
#
#
###################################################

from scapy.all import *
from datetime import datetime
import csv, time

PROBE_REQUEST_TYPE=0
PROBE_REQUEST_SUBTYPE=4

WHITELIST = ['de:ad:be:ef:ca:fe'] # Replace this with your phone's MAC address

def PacketHandler(pkt):
    if pkt.haslayer(Dot11):
        if pkt.type==PROBE_REQUEST_TYPE and pkt.subtype == PROBE_REQUEST_SUBTYPE and ( pkt.addr2.lower() not in WHITELIST and pkt.addr2.upper() not in WHITELIST):
            PrintPacket(pkt)

def PrintPacket(pkt):
    try:
        extra = pkt.notdecoded
    except:
        extra = None
    if extra!=None:
        signal_strength = -(256-ord(extra[-4:-3]))
    else:
        signal_strength = -100
        print "No signal strength found"
    with open('logmacs.csv','rb') as read:
        reader=csv.reader(read)
        for row in reader:
            if pkt.addr2 == row[2]:
                count=1
            else:
                count=0
        read.close()

    print "MAC: %s SSID: %s RSSi: %d"%(pkt.addr2,pkt.getlayer(Dot11ProbeReq).info,signal_strength)

def main():
    print "[%s] Starting scan"%datetime.now()
    print "Scanning..."
    sniff(iface=sys.argv[1],prn=PacketHandler,store=0)

if __name__=="__main__":
    main()


