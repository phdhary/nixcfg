/usr/libexec/xfce-polkit&
dunst&
slstatus&
xob_server&
wrapped_picom&
sxhkd -c ~/.config/sxhkd/sxhkdrc.common &
nitrogen --restore
xset dpms 600 600 0
rfkill block bluetooth
while true; do
  caffeine start &
  nm-applet --indicator &
  dwm >/dev/null 2>&1
done
