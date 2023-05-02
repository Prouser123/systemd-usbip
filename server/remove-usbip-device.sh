#!/bin/bash -e

# Remove the temporary marker (signals the configure script to stop running)
rm /tmp/usbip-${USB_IDVENDOR}-${USB_IDPRODUCT}

# Find and unbind the device
BUS_ID=`/usr/sbin/usbip list -p -l | grep -i "#usbid=${USB_IDVENDOR}:${USB_IDPRODUCT}#" | cut '-d#' -f1`
[[ -z "$BUS_ID" ]] || /usr/sbin/usbip unbind --$BUS_ID

