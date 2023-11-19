#!/bin/sh

while true; do
    # Log stderror to a file 
    #
    /home/laken/.config/nixcfg/result/bin/dwm 2> ~/.dwm.log
    # No error logging
    #dwm >/dev/null 2>&1
done
