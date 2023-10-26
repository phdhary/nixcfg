#!/bin/sh

current=$(bspc query -T -d | jq .name | sed 's/[^0-9]*//g');
destination="$1";

bspc desktop -s "$destination" --rename "$destination";
bspc desktop "^$current" --rename "$current";
