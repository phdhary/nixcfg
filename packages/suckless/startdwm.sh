_run() { $@ & }
_run nitrogen --restore 
# feh --bg-fill $(< .config/nitrogen/bg-saved.cfg | sed -n 2p | sed 's/file=//')
_run /usr/libexec/xfce-polkit 
_run dunst 
_run slstatus 
_run xob_server 
_run wrapped_picom 
_run sxhkd -c ~/.config/sxhkd/sxhkdrc.common 
_run xset dpms 600 600 0 
_run rfkill block bluetooth 
while true; do
  _run caffeine start
  _run nm-applet --indicator
  dwm >/dev/null 2>&1
done
