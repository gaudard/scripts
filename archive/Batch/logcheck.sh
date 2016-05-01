#!/bin/bash

cp /tmp/mailer.txt /tmp/newmail.txt		# Create new email txt file.

if [ ! -e /tmp/opened ] ; then			#if there's no 'opened' file
  grep "track" /var/log/nginx/access.log > /tmp/opened 		# Search for the word track, since that is where the images are saved.
  cat /tmp/opened >> /tmp/newmail.txt
  ssmtp YOU@SOME.COM < /tmp/newmail.txt	
  # and mail its contents
else
  count=` comm -23 <(grep "track" /var/log/nginx/access.log) /tmp/opened | wc -l `
  if [ $count -eq 0 ]; then
    echo "zero new entries ` date ` " >> /tmp/logcheck.log
  else
    comm -23 <(grep "track" /var/log/nginx/access.log) /tmp/opened >> /tmp/newmail.txt		# adds new entries to email txt.
    ssmtp YOU@SOME.COM < /tmp/newmail.txt			# it already exists and contains previous log entries.
    grep "track" /var/log/nginx/access.log > /tmp/opened		# Update opened with new entries.
  fi
fi

rm /tmp/newmail.txt		# Make sure shit is cleaned up.
