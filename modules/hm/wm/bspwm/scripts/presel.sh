#!/bin/bash

usage() {
    cat <<EOM
usage: $(basename $0) [help] [increase] [decrease]
    help        Displays this message
    increase    increase presel ratio
    decrease    decrease presel ratio
EOM
    exit 0
}

[ "$1" = "help" ] && usage


# Get preselection ratio. Will be null if the current node has no preselection.
ratio=$(bspc query -T -n focused | jq -r ".presel.splitRatio")

# Check if ratio is null
[ "$ratio" == "null" ] && exit

case "$1" in
  increase)
    [ "$ratio" = 0.9 ] && exit
    ratio=$(awk "BEGIN {print $ratio + 0.1}")
    ;;
  decrease) 
    [ "$ratio" = 0.1 ] && exit
    ratio=$(awk "BEGIN {print $ratio - 0.1}")
    ;;
esac
bspc node -o "$ratio"
