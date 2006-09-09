#!/usr/local/bin/bash

if [ "$1" = "" ]
then
  ARGS=$(date +%d/%b/%Y)
else
  ARGS=$*
fi

# MMAP="--mmap"
MMAP=""

for DAY in $ARGS
do
  grep $MMAP $DAY /var/www/logs/access_log* | grep msadc | awk '{print $1}' | cut -d: -f2 | sort | uniq > /tmp/viruses.$$
  HITS=$(grep $MMAP $DAY /var/www/logs/access_log* | wc -l)
  NON_VIRUS_HITS=$(grep $MMAP $DAY /var/www/logs/access_log* | grep -v -f /tmp/viruses.$$  | wc -l)
  echo "$DAY $NON_VIRUS_HITS/$HITS"
done

