#!/bin/bash
# 进入项目文件夹，此步骤可以在jenkins里写
rm -rf report/*
rm -rf *.crash
rm -rf crashreport/*
cd /Users/wangshuai/work/git/WebDriverAgent
instruments -w device > devices.log
device_num=`more devices.log  | grep -v '-' | grep '(' | wc -l`
for ((i=1;i<=$device_num;i++))
do 
device=`more devices.log  | grep -v '-' | grep '(' |awk -F '[' '{print $2}' |awk -F ']' '{print $1}' | sed -n "${i}p"`
echo $device
if [ "$device_num" -eq 1 ]
    then

    xcodebuild test -scheme 'IntegrationApp' -destination "platform=iOS,id=$device" -resultBundlePath "/Users/wangshuai/work/git/ios_monkey_lemon/report/$device"
    continue
    else
    	if [ "$j" -eq "$device_num" ]
    	then
    	xcodebuild test -scheme 'IntegrationApp' -destination "platform=iOS,id=$device" -resultBundlePath "/Users/wangshuai/work/git/ios_monkey_lemon/report/$device"
		else
		xcodebuild test -scheme 'IntegrationApp' -destination "platform=iOS,id=$device" -resultBundlePath "/Users/wangshuai/work/git/ios_monkey_lemon/report/$device"&
		fi
	fi
done
sleep 100s
pid=`ps -a | grep run.sh | grep -v grep| awk '{s=$1} END {print s}'`
kill -9 $pid
pid=`ps -a | grep run.sh | grep -v grep| awk '{s=$1} END {print s}'`
kill -9 $pid
pid=`ps -a | grep run.sh | grep -v grep| awk '{s=$1} END {print s}'`
kill -9 $pid