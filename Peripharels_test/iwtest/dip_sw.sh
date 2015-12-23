#!/bin/sh
if [ -c /dev/dip_sw ]
then 
	./dip-switch.out
else
	mknod /dev/dip_sw c 248 0
	./dip-switch.out
fi
