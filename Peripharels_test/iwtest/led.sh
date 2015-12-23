#!/bin/sh
if [ -c /dev/led ]
then 
	./led.out
else
	mknod /dev/led c 249 0
	./led.out
fi
