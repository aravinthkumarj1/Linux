
############# ETHERNET Test ##########################
ifconfig eth0 up
export ethernet=`cat /sys/class/net/eth0/carrier`
if [ $ethernet -eq 1 ]
then
        echo "Ethernet cable connected"
        echo "Starting Ethernet test"
        udhcpc -i eth0 > /TestResults.txt
        ping google.com -c 1
        export e_test=`echo $?`
        echo "e_test:"
        echo $e_test
        if [ $e_test -eq 0 ]
        then
                echo "Ethernet test successful"
        else
                echo "Ethernet test not successful"
        fi
else
        echo "Ethernet cable not connected"
fi

############# AUDIO Test #############################

export Audio=`cat /sys/bus/platform/drivers/imx-wm8962/headphone`
echo "Audio:"
echo $Audio
if [ "$Audio" == "headphone" ]
then
        echo "Headphone connected"                           
        echo "starting Audio out test"
	aplay -D plughw:0,0 /mc50sd2.wav
        export a_test=`echo $?`
        echo "a_test:"
        echo $a_test
        if [ $a_test -eq 0 ]
	then
		echo "Audio test successful"
	else
		
		echo "Audio test not successful"
	fi
else
	echo "Headphone not connected"
fi

############# HDMI Test ###############################

export HDMI=`cat /sys/devices/platform/mxc_hdmi/cable_state`
echo "HDMI:"
echo $HDMI
if [ "$HDMI" == "plugin" ]
then
	echo "HDMI cable connected"
	echo "starting HDMI test"
	cat /iwtest/1080p1.bin > /dev/fb0
	export h_test=`echo $?`
	echo "h_test:"
	echo $h_test
	if [ $h_test -eq 0 ]
	then
		echo "HDMI test successful"
	else
		echo "HDMI test not successful"
	fi
else
	echo "HDMI cable not connected"
fi

############ USB-OTG Test ################################

export OTG=`cat /sys/devices/platform/fsl-ehci.0/usb1/power/runtime_status`
echo "OTG:"
echo $OTG
if [ "$OTG" == "active" ]
then
	echo "USB-OTG cable connected"
	echo "starting USB-OTG test"
	insmod /iwtest/g_file_storage.ko file=/dev/mmcblk1p1 removable=1
	export o_test=`echo $?`
	echo "o_test:"
	echo $o_test
	if [ $o_test -eq 0 ]
	then
		echo "USB-OTG test successful"
	else
		echo "USB-OTG test not successful"
	fi
else
	echo "USB-OTG cable not connected"
fi




