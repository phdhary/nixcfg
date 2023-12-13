#!/bin/sh

while :
do
  mpc current --wait;
  artist="$(mpc current -f %artist%)";
  title="$(mpc current -f %title%)";
  ffmpeg -i "$HOME/Music/$(mpc current -f %file%)" -an -c:v copy /tmp/mpc_current.jpg -y;
  is_album_exist=$?;
  [ -z "$artist" -a -z "$title" -a -z "$(mpc current)" ] && continue;
  [ ${#artist} -gt 40 ] && artist="$(echo "$artist" | cut -c-40)...";
  if [ -z "$artist" -o -z "$title" ]; then
    artist="Now playing";
    title="$(mpc current | sed 's@.*/@@')";
  fi
  icon_flag="-i /tmp/mpc_current.jpg";
  [ $is_album_exist -eq 1 ] && icon_flag="";
  dunstify -C 1234
  dunstify -u low -r 1234 "$artist" "$title" $icon_flag;
done
