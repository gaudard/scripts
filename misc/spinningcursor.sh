#################################################
# Copied by @jgaudard  :: I don't twitter much 
# Script to create rotating cursor, found on stackoverflow
# Copied: 26 June 2016    Edited:
# Version 1.0
# http://stackoverflow.com/questions/12498304/using-bash-to-display-a-progress-working-indicator
#################################################

ping -c 10 127.0.0.1 1> /dev/nul &
pid=$! # Process Id of the previous running command

spin='-\|/'

i=0
while kill -0 $pid 2>/dev/null
do
  i=$(( (i+1) %4 ))
  printf "\r${spin:$i:1}"
  sleep .1
done

