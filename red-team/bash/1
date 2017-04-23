#################################################
# Created by @jgaudard  :: I don't twitter much
# Creates a list of targets, requires nmap 
# Created: 23 April 2017 Modified: 
# Version 0.9   ## not working yet...
#################################################
diii
RANDOM="False"
OUT=""
TARGETS=""

if [ "$1" == "" ]
then
	echo "Usage ./targets.sh [options]"
	echo "Use -h or --help for more information"
	exit 0
fi

while [ "$1" != "" ]; do
	case $1 in
		-h|--help)
                	echo "Usage ./targets.sh [options]"
                	echo ""
                	echo "-h, --help			you are looking at it"
                	echo "-r, --random			randomize targets"
                	echo "-w, --out				output to file" 
                	echo "-t, --targets			targets" 
                	echo ""
                	echo "Examples:"
                	echo "	./targets.sh -r -w targets.lst -t 192.168.0.0/24"
                	                	
                	
                        exit 0
                        ;;
                -r|--random)		
                	shift
                	RANDOM="True"
                	;;
                -w|--out)		
                	shift
                        OUT=$1
                        ;;
                -t|--targets)
                	shift
                        TARGETS=$1
                        ;;
                * )
                        break
                        ;;
                esac
                shift
        done

if [ RANDOM == "True" ]
then
	/usr/bin/nmap --randomize-hosts -nsL $TARGETS | awk '{ print $5 }' | egrep [0-9]
else
	/usr/bin/nmap -nsL $TARGETS | awk '{ print $5 }' | egrep [0-9]
fi	

echo "$TARGETS"
