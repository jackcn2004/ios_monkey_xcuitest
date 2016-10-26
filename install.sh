#!/bin/bash
instruments -w device > devices.log
more 
device_num=`more devices.log  | grep -v '-' | grep '(' | wc -l`
for ((i=1;i<=$device_num;i++))
do 
	 device=`more devices.log  | grep -v '-' | grep '(' |awk -F '[' '{print $2}' |awk -F ']' '{print $1}' | sed -n "${i}p"`
	 echo $device
	 #xcodebuild -target IntegrationApp -configuration Release
	 #xcrun -sdk iphoneos  PackageApplication -v /Users/wangshuai/work/git/WebDriverAgent/build/Debug-iphoneos  -o /Users/wangshuai/work/git/WebDriverAgent/IntegrationApp.ipa
	 ideviceinstaller -i /Users/pc/work/git/solar-ios/build/ipa/*ipa -u $device
done