#!/bin/bash -e

previousState = 1
state = $(/usr/bin/lsusb | grep -q ${USB_IDVENDOR}:${USB_IDPRODUCT}; echo $?)


TMPFILE=/tmp/usbip-${USB_IDVENDOR}-${USB_IDPRODUCT}

touch $TMPFILE

# Check to see if the tmp file exists (will be deleted when service is stopped)
while [[ -e $TMPFILE ]]
do
    # Check to see if the state has changed
    if [ $state -ne $previousState]; then
        BUS_ID=`/usr/sbin/usbip list -p -l | grep -i "#usbid=${USB_IDVENDOR}:${USB_IDPRODUCT}#" | cut '-d#' -f1`
        [[ -z "$BUS_ID" ]] || /usr/sbin/usbip bind --$BUS_ID
    fi
    
    # Update the state
    sleep 1
    previousState=$state
    state = $(/usr/bin/lsusb | grep -q ${USB_IDVENDOR}:${USB_IDPRODUCT}; echo $?)
done
