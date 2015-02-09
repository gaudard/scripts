#!/bin/bash
rm -f /tmp/testfifo
mkfifo /tmp/testfifo
echo "Welcome to Chicago where the local time is `date`"
function serve {
  echo "What do you want to see?"
  read command
  while true; do
    if [ "x$command" == "x" ]; then
      echo "please enter a command"
    elif [ "$command" == "list" ]; then
      ps -ef
    elif [ "$command" == "stat" ]; then
      netstat -i
    elif [ "$command" == "disk" ]; then
      df -h
    elif [ "$command" == "exit" ]; then
      break
    fi
    echo "What do you want to see?"
    read command
  done
  exit
}
cat /tmp/testfifo | /usr/local/bin/nc -l -p 31338 | serve > /tmp/testfifo
echo "Thank you for flying Delta"
