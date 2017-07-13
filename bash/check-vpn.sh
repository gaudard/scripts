#!/bin/bash
SERVERIP=8.8.8.8
RUNNING=2
DATE=`date`
pgrep openvpn && RUNNING=1 || RUNNING=0

if [ $RUNNING = "0" ]; then
        conf=`ls /etc/openvpn/*.ovpn | sort -R | tail -n1`
        sudo openvpn --config $conf --ca /etc/openvpn/ca.rsa.2048.crt --crl-verify /etc/openvpn/crl.rsa.2048.pem --auth-user-pass /etc/openvpn/auth.txt &
        echo "$DATE     Started openvpn" >> /var/log/irclogs/vpnstatus.log
        sleep 5
        curl ipinfo.io | egrep -A 3 \"ip\"\: >> /var/log/irclogs/vpnstatus.log
else
        ping -c 3 $SERVERIP > /dev/null 2>&1
        if [ $? -ne 0 ]; then
                conf=`ls /etc/openvpn/*.ovpn | sort -R | tail -n1`
                sudo killall openvpn
                sleep 5
                sudo openvpn --config $conf --ca /etc/openvpn/ca.rsa.2048.crt --crl-verify /etc/openvpn/crl.rsa.2048.pem --auth-user-pass /etc/openvpn/auth.txt &
                echo "$DATE     Restarted openvpn" >> /var/log/irclogs/vpnstatus.log
                sleep 5
                curl ipinfo.io | egrep -A 3 \"ip\"\: >> /var/log/irclogs/vpnstatus.log
        fi
fi
