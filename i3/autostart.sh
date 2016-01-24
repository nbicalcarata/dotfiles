#!/bin/sh
nm-applet &
sleep 2
redshift-gtk -l 24.0:-104.6 -t 6800:4100 &
diodon &
megasync
