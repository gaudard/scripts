###################################################
#
# Code from: http://edwardkeeble.com/2014/02/passive-wifi-tracking/
# Modified by @jgaudard started on 24 April 2015
#
# Scans for MACs that are not in the whitelist
# then prints them to the screen including MAC,
# SSID, Signal Strength after searching csv.
#
# Format for CSV: 0 MAC,1 SigStrenght,2 yyyy-mm-dd,3 hh:mm,4 yyyy-mm-dd,5 hh:mm,6 yyyy-mm-dd,7 hh:mm,8 yyyy-mm-dd,9 hh:mm,10 SSID,11 SSID,12 SSID,13 SSID
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
    with open('logphones.csv','rb') as read:
        reader=csv.reader(read, delimiter=',')
        for row in reader:
            if pkt.addr2 == row[0]:
                themacexist=1
                break
            else:
                themacexist=0
        read.close()
    if themacexist==1:
        EditExisting(pkt)
    elif themacexist==0:
        WriteNew(pkt,signal_strength)
    else:
        print "error"

def WriteNew(pkt,signal_strength):
    with open('logphones.csv','ab') as out:
        w=csv.writer(out)
        w.writerow([pkt.addr2,signal_strength,datetime.now().strftime('%Y-%m-%d'),datetime.now().strftime('%H:%M'),'blank','blank','blank','blank',pkt.getlayer(Dot11ProbeReq).info])
        print "MAC: %s SSID: %s"%(pkt.addr2,pkt.getlayer(Dot11ProbeReq).info)
        out.close()

def EditExisting(pkt):
    return
    '''
    reader = csv.reader(open('logphones.csv','rb'))
    writer = csv.writer(open('logphones.csv','wb'))
    for row in reader:
        if pkt.addr2 == row[0]:
            if not pkt.getlayer(Dot11ProbeReq).info in row[10:]:
                print "ssid is not in csv"
    '''

def main():
    print "[%s] Starting scan"%datetime.now()
    print "Scanning..."
    sniff(iface=sys.argv[1],prn=PacketHandler,store=0)
if __name__=="__main__":
    main()

