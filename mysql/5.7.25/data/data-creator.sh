#!/bin/bash

echo start
date "+%Y-%m-%d %H:%M:%S"

if [ -e created_data.csv ]; then
  rm created_data.csv 
fi

if [ $# -eq 0 ]; then
  echo "Specify 1 argument with number"
  exit 0
fi
num=${1}

array[0]="event0"
array[1]="event1"
array[2]="event2"
array[3]="event3"
array[4]="event4"
array[5]="event5"
array[6]="event6"
array[7]="event7"
array[8]="event8"
array[9]="event9"
size=${#array[@]}
index=$(($RANDOM % $size))

res=""
for i in $(seq 1 ${num})
do
  index=$(($RANDOM % $size))
  res="${i},${i},${array[$index]}"
  echo ${res} >> created_data.csv
  res=""
done

date "+%Y-%m-%d %H:%M:%S"
echo end
