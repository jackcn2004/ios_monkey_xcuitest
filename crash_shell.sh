#!/bin/bash
export DEVELOPER_DIR="/Applications/Xcode.app/Contents/Developer"
sleep 3s
num=`ls | grep ".crash" | grep -v sym | wc -l`
for ((i=1;i<=$num;i++))
do
	 #device_serialname = `idevice_id -l | awk '{print $1}' | sed -n "${i}p"`
	 crashid=`ls | grep ".crash" | grep -v sym |sed -n "${i}p"`
	 echo $crashid
	 #echo $i
	 ./symbolicatecrash $crashid > crashreport/$crashid.log

done