#!/bin/bash




echo "We are about to do a full system inventory. Please be patient......"

echo "The kernel version is : "
uname -r
echo " "

echo "Your memory size is : "
free -m
echo " "
echo "Your hardrive(s) info below : "
lsblk
echo " "
echo "Number of cpu : "
npro


echo " "
echo "Your OS version is : "
cat /etc/os-release
echo " "
echo " checking your system bits..."
getconf LONG_BIT
echo " "
echo "Your CPU stats are : "
lscpu
echo " "

echo " What is our system load averages? "
uptime
