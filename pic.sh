#!/bin/bash

#instruments -w device > devices.log
device_num=`ls report| wc -l`
echo $device_num
for ((i=1;i<=$device_num;i++))
do 
	#device=`more devices.log  | grep -v '-' | grep '(' |awk -F '[' '{print $2}' |awk -F ']' '{print $1}' | sed -n "${i}p"`
	device=`ls report| sed -n "${i}p"`
	echo $device
	cd report
	cp -r -f $device/Attachments/*.crash ../$device.crash
	crash_num=`ls $device/Attachments/*.crash | wc -l`
	echo $crash_num
	echo "" > $device.html
	echo "<html><head><title>Monkey ScreenShot</title></head><body>" >> $device.html
	if [ "$crash_num" -eq 1 ]
		then
		echo "<p align="center">--------------------------💖💖💖💖💖💖程序崩溃啦💖💖💖💖💖💖--------------------------------</p>" >>$device.html
	else
		echo "<p align="center">--------------------------💖💖💖💖💖💖程序无崩溃💖💖💖💖💖💖--------------------------------</p>" >>$device.html
	fi
	echo "<p align="center">--------------------------💖💖💖💖💖💖monkey💖💖💖💖💖💖--------------------------------</p>" >>$device.html

	num=`ls $device/Attachments/ | grep png |wc -l`
	echo $num
	for ((j=1;j<=$num;j++))
	do
		#sort -n -t " " -k 2 
		jpg="$device/Attachments/"`ls -lrt $device/Attachments/ | grep png |awk '{print $9}'| sed -n "${j}p"`
		echo $jpg
 	 echo "<img src=\"$jpg\"/ width="240" height="320" >   " >> $device.html
  	done
  	
done



