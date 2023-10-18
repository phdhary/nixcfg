#!/bin/sh

light_fifo_file=/tmp/xobpipelight
if [ -p "$light_fifo_file" ]; then
    echo "$light_fifo_file exists."
else 
    echo "creating fifo $light_fifo_file"
    mkfifo "$light_fifo_file"
fi

volume_fifo_file=/tmp/xobpipevolume
if [ -p "$volume_fifo_file" ]; then
    echo "$volume_fifo_file exists."
else 
    echo "creating fifo $volume_fifo_file"
    mkfifo "$volume_fifo_file"
fi

kill "$(ps ax | grep "tail -f "$light_fifo_file"" | grep -v grep | awk '{print $1}')"
kill "$(ps ax | grep "@xob@ -s brightness" | grep -v grep | awk '{print $1}')"
tail -f "$light_fifo_file" | @xob@ -s brightness &

kill "$(ps ax | grep "tail -f "$volume_fifo_file"" | grep -v grep | awk '{print $1}')"
kill "$(ps ax | grep "@xob@ -s volume" | grep -v grep | awk '{print $1}')"
tail -f "$volume_fifo_file" | @xob@ -s volume &
