# Updates using apt-get
#Setting Color Variables

Red='\033[0;31m'
Black='\033[0;30m'
Blue='\033[0;34m'
Green='\033[0;32m'
Cyan='\033[0;36m'
Purple='\033[0;35m'
Brown='\033[0;33m'
LGray='\033[0;37m'
DGray='\033[1;30m'
Yellow='\033[1;33m'
White='\033[1;37m'
NC='\033[0m' # No Color


echo
echo -e "${Yellow}Running Update Script${NC}"
echo
echo
echo -e "${White}[+] Running Update${NC}"
echo
apt-get update -y

echo
echo -e "${White}[+] Running Upgrade${NC}"
echo
apt-get upgrade -y

echo
echo -e "${White}[+] Running Dist-Upgrade${NC}"
echo
apt-get dist-upgrade -y

echo
echo -e "${White}[+] Running Autoremove${NC}"
echo
apt-get autoremove -y

echo
echo -e "${White}[+] Running Autoclean${NC}"
echo
apt-get autoclean -y

echo
echo -e "${Yellow}[*] Updating Complete${NC}"
echo

