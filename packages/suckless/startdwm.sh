_kill_and_run() {
  kill "$(ps ax | grep "$1" | grep -v grep | awk '{print $1}')"; "$@" & >/dev/null 2>&1
}

while :
do
  export _JAVA_AWT_WM_NONREPARENTING=1
  nitrogen --restore 
  xset dpms 600 600 0 
  rfkill block bluetooth 
  xrdb ~/.config/X/Xresources
  cat ~/.config/dunst/dunstrc ~/.local/state/dunst/current_color >> /tmp/dunstconfig
  _kill_and_run /usr/libexec/xfce-polkit 
  _kill_and_run dunst -conf /tmp/dunstconfig
  _kill_and_run slstatus 
  _kill_and_run wrapped_picom 
  _kill_and_run sxhkd -c ~/.config/sxhkd/sxhkdrc.common 
  _kill_and_run caffeine start
  _kill_and_run nm-applet --indicator
  _kill_and_run ~/.config/nixcfg/packages/scripts/notify-mpd.sh
  dwm >/dev/null 2>&1
  # dwm 2> ~/.dwm.log
  # /home/laken/.config/nixcfg/result/bin/dwm >/dev/null 2>&1
done
