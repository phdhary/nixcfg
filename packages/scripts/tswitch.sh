#!/bin/bash

NIXCFG_ROOT=~/.config/nixcfg
HM="$NIXCFG_ROOT"/modules/hm
PROGRAMS="$HM"/programs
WM="$HM"/wm

list=()
themes=$(\ls -1 "$PROGRAMS"/alacritty/themes/ | sed 's/.yml//')
current=$(cat ~/.local/state/alacritty/current_theme.yml | tail -1 | awk '{print $2}' | cut -c28- | sed 's/.yml//')
# add current first
list+=("$current")
# add the rest of themes
for item in ${themes[@]}; do
  [ "$item" != "$current" ] && list+=("$item")
done

# selected=$(printf "%s\n" "${list[@]}" | fzf --layout=reverse)
# selected=$(printf "%s\n" "${list[@]}" | dmenu -fn "SF Pro Display")
selected=$(printf "%s\n" "${list[@]}" | rofi -dmenu -no-custom -p " " -matching fuzzy -theme-str '#window { width: 25%; }')
[ -z "$selected" -o "$selected" = "$current" ] && exit

declare theme_mode
case "$selected" in
  *"light"*|*"lotus"*|*"day"*|*"latte"*|*"dawn"*) theme_mode="light" ;;
  *) theme_mode="dark" ;;
esac

query_color() {
  local mode=$1
  local file=~/.config/alacritty/themes/"$selected".yml
  case $mode in
    1) # first match
      grep -i "$2" $file | head -1 | awk '{print $2}' | sed 's/\"//g' | sed "s/'//g" ;;
    2) # second match
      grep -i "$2" $file | head -2 | tail -1 | awk '{print $2}' | sed 's/\"//g' | sed "s/'//g" ;;
  esac
}

# query alacritty's theme
colors_background=$(query_color 1 "background")
colors_foreground=$(query_color 1 "foreground")
# normal
colors_black=$(query_color 1 "black")
colors_red=$(query_color 1 "red")
colors_green=$(query_color 1 "green")
colors_yellow=$(query_color 1 "yellow")
colors_blue=$(query_color 1 "blue")
colors_magenta=$(query_color 1 "magenta")
colors_cyan=$(query_color 1 "cyan")
colors_white=$(query_color 1 "white")
# bright
colors_bright_black=$(query_color 2 "black")
colors_bright_red=$(query_color 2 "red")
colors_bright_green=$(query_color 2 "green")
colors_bright_yellow=$(query_color 2 "yellow")
colors_bright_blue=$(query_color 2 "blue")
colors_bright_magenta=$(query_color 2 "magenta")
colors_bright_cyan=$(query_color 2 "cyan")
colors_bright_white=$(query_color 2 "white")

apply_alacritty() {
  sed -i -r "2s/$current/$selected/" ~/.local/state/alacritty/current_theme.yml
}

apply_nvim() {
  sed -i -r "/vim.g.current_colorscheme/ s/\".*/\"$selected\"/" ~/.local/state/nvim/lua/user/current_colorscheme.lua
  killall -USR1 nvim
}

apply_polybar() {
  declare sed_str
  declare -A arr
  arr["background"]=$colors_background
  arr["foreground"]=$colors_foreground
  arr["primary"]=$colors_foreground
  arr["secondary"]=$colors_green
  arr["alert"]=$colors_red
  arr["disabled"]=$colors_bright_black
  arr["background\-alt"]=$colors_bright_black
  for key in ${!arr[@]}; do
    sed_str+="0,/${key}/ s/${key}.*/${key} = ${arr[$key]}/ ; "
  done
  # sed -i -e "$sed_str" "$PROGRAMS"/polybar/current.ini
  sed -i -e "$sed_str" ~/.local/state/polybar/current.ini
  polybar-msg cmd restart
}

apply_bspwm() {
  local normal_border_color=$colors_bright_black
  declare focused_border_color
  declare sed_str
  declare -A arr
  case "$theme_mode" in
    light) focused_border_color=$colors_magenta ;;
    dark) focused_border_color=$colors_blue ;;
  esac
  bspc config 'normal_border_color' "$normal_border_color"
  bspc config 'focused_border_color' "$focused_border_color"
  arr["normal_border_color"]=$normal_border_color
  arr["focused_border_color"]=$focused_border_color
  for key in ${!arr[@]}; do
    sed_str+="/${key}/s/'#.*'/'${arr[$key]}'/ ; "
  done
  # sed -i -e "$sed_str" "$PROGRAMS"/bspwm/current_border_color
  sed -i -e "$sed_str" ~/.local/state/bspwm/current_border_color
}

apply_dunst() {
  declare sed_str
  declare -A arr
  arr[4]=$colors_background
  arr[5]=$colors_foreground
  arr[11]=$colors_blue
  arr[12]=$colors_background
  arr[19]=$colors_red
  arr[20]=$colors_background
  for key in ${!arr[@]}; do
    sed_str+="${key}s/=.*/= \"${arr[$key]}\"/ ; "
  done
  # sed -i -e "$sed_str" "$PROGRAMS"/dunst/current_color
  sed -i -e "$sed_str" ~/.local/state/dunst/current_color
  cat ~/.config/dunst/dunstrc ~/.local/state/dunst/current_color >> /tmp/dunstconfig
  pid=$(pidof dunst); kill $pid && dunst -conf /tmp/dunstconfig &
}

apply_xob() {
  declare sed_str
  declare -A arr
  arr[13]=$colors_foreground
  arr[14]=$colors_background
  arr[15]=$colors_bright_black
  arr[18]=$colors_bright_black
  arr[19]=$colors_background
  arr[20]=$colors_bright_black
  for key in ${!arr[@]}; do
    sed_str+="${key}s/=.*/= \"${arr[$key]}\";/ ; "
  done
  sed -i -e "$sed_str" ~/.config/xob/styles.cfg
  nohup xob_server >/dev/null 2>&1
}

apply_rofi() {
  declare sed_str
  declare -A arr
  arr[2]=$colors_background;
  arr[3]=$colors_black;
  arr[4]=$colors_foreground;
  arr[5]=$colors_foreground;
  arr[6]=$colors_background;
  arr[7]=$colors_red;
  arr[8]=$colors_magenta;
  for key in ${!arr[@]}; do
    sed_str+="${key}s/\:.*/: ${arr[$key]};/ ; "
  done
  # sed -i -e "$sed_str" "$PROGRAMS"/rofi/current_color.rasi
  sed -i -e "$sed_str" ~/.local/state/rofi/current_color.rasi
}

toggle_gnome() {
  declare mode
  case "$theme_mode" in
    light) mode="default" ;;
    dark) mode="prefer-dark" ;;
  esac
  gsettings set org.gnome.desktop.interface color-scheme "$mode"
  case "$mode" in
    default) mode=0 ;;
    prefer-dark) mode=1 ;;
  esac
  sed -i "0,/gtk-application-prefer-dark-theme/ s/=.*/=$mode/" ~/.config/gtk-3.0/settings.ini
  # pkill nm-applet && nm-applet --indicator & >/dev/null 2>&1 
  # caffeine kill && caffeine start & >/dev/null 2>&1 
}

apply_cava() {
  declare sed_str
  declare -A arr
  arr[163]=$colors_bright_green;
  arr[164]=$colors_bright_yellow;
  arr[165]=$colors_bright_red;
  for key in ${!arr[@]}; do
    sed_str+="${key}s/\=.*/= '${arr[$key]}'/ ; "
  done
  sed -i -e "$sed_str" ~/.config/cava/config
}

apply_xresource() {
  declare sed_str
  declare -A arr
  arr["dwm.normbgcolor"]=$colors_background
  arr["dwm.normbordercolor"]=$colors_bright_black
  arr["dwm.normfgcolor"]=$colors_foreground
  arr["dwm.selfgcolor"]=$colors_background
  arr["dwm.selbordercolor"]=$colors_cyan
  arr["dwm.selbgcolor"]=$colors_foreground
  for key in ${!arr[@]}; do
    sed_str+="/${key}/ s/\:.*/\: ${arr[$key]}/ ; "
  done
  sed -i -e "$sed_str" ~/.config/X/Xresources
  xrdb ~/.config/X/Xresources
  xdotool key "Super_L+F5"
}

apply_xresource
apply_alacritty
apply_nvim
apply_polybar
apply_bspwm
apply_dunst
apply_xob
apply_rofi
apply_cava
toggle_gnome
