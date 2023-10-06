#!/bin/sh

noteFilename="$HOME/Documents/cok/Scratch/note-$(date +%Y-%m-%d).md"

if [ ! -f "$noteFilename" ]; then
    echo "# Notes for $(date +%Y-%m-%d)" > "$noteFilename"
fi

@nvim@ -c "lua AutoSaveFlag=false"\
    -c "norm Go" \
    -c "norm Go## $(date +%H:%M)" \
    -c "norm G2o" \
    -c "norm zz" \
    -c "startinsert" "$noteFilename"
