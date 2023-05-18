#!/bin/bash

#Description: script for inventory
#Author: Dominique, Feb 2022


echo "We are about to do a full system inventory. Please be patient......"
sleep 4
echo
echo "The kernel version is : "
sleep 1
uname -r
echo " "

sleep 1
echo "Your memory is : "
sleep 1
free -m
echo " "
sleep 1
echo "Your hardrive(s) info below : "
sleep 1
lsblk
echo " "

sleep 1

echo "Your OS version is : "
sleep 1
cat /etc/*release
echo " "
sleep 1

echo " checking your system bits..."
sleep 1
arch
echo " "
sleep 1
echo "Your CPU stats are : "
sleep 1
lscpu
echo " "
sleep 1

echo " What is our system load averages? "
sleep 1
uptime
sleep 3