#!/bin/sh

nixcfg_root=~/.config/nixcfg
hm="$nixcfg_root"/modules/hm
programs="$hm"/programs
wm="$hm"/wm

# get theme list
list=$(\ls -1 "$programs"/alacritty/themes/ | sed 's/.yml//')

# get current theme
current=$(cat "$programs"/alacritty/current_theme.yml | tail -1 | awk '{print $2}' | cut -c28- | sed 's/.yml//')

# prompt
# selected=$(printf "%s\n" "${list[@]}" | fzf --layout=reverse)
selected=$(printf "%s\n" "${list[@]}" | rofi -dmenu -no-custom -p "($current)" -matching fuzzy -theme-str '#window { width: 25%; }')

[ -z "$selected" ] && exit

[ "$selected" = "$current" ] && exit

sadd_first_only() {
  sed -i "0,/$1/ s/.*$1.*/$2/" $3
}

query_color() {
  local mode=$1
  local file=~/.config/alacritty/themes/"$selected".yml
  case $mode in
    1) 
      grep -i "$2" $file | head -1 | awk '{print $2}' | sed 's/\"//g' | sed "s/'//g"
    ;;
    2)
      grep -i "$2" $file | head -2 | tail -1 | awk '{print $2}' | sed 's/\"//g' | sed "s/'//g"
    ;;
  esac
}

# query alacritty's theme
colors_background=$(query_color 1 "background")
colors_foreground=$(query_color 1 "foreground")
colors_blue=$(query_color 1 "blue")
colors_green=$(query_color 1 "green")
colors_red=$(query_color 1 "red")
colors_yellow=$(query_color 1 "yellow")
colors_bright_black=$(query_color 2 "black")

apply_alacritty() {
  local file="$programs"/alacritty/current_theme.yml
  sed -i -r "2s/$current/$selected/" $file;
}

apply_nvim() {
  local file="$programs"/neovim/nvim/lua/user/config.lua
  sed -i -r "/colorscheme/ s/\=.*/\= \"$selected\",/" $file
  killall -USR1 nvim
}

apply_polybar() {
  local file="$programs"/polybar/config.ini
  sadd_first_only "background" "background = $colors_background" $file
  sadd_first_only "background\-alt" "background\-alt = $colors_bright_black" $file
  sadd_first_only "foreground" "foreground = $colors_foreground" $file
  sadd_first_only "primary" "primary = $colors_foreground" $file
  sadd_first_only "secondary" "secondary = $colors_green" $file
  sadd_first_only "alert" "alert = $colors_red" $file
  sadd_first_only "disabled" "disabled = $colors_bright_black" $file
  # polybar-msg cmd restart
}

apply_bspwm() {
  local file="$wm"/bspwm/bspwmrc
  sadd_first_only "normal_border_color" "bspc config 'normal_border_color'     '$colors_bright_black'" $file
  sadd_first_only "focused_border_color" "bspc config 'focused_border_color'    '$colors_blue'" $file

  bspc config 'normal_border_color' "$colors_bright_black"
  bspc config 'focused_border_color' "$colors_blue"
}

apply_dunst() {
  local file="$programs"/dunst/dunstrc
  _replace_dunst() {
    sed -i -r "$1s/=.*/= \"$2\"/" $file
  }
  _replace_dunst 316 $colors_bright_black
  _replace_dunst 317 $colors_foreground
  _replace_dunst 323 $colors_blue
  _replace_dunst 325 $colors_background
  _replace_dunst 331 $colors_red
  _replace_dunst 332 $colors_background
  pid=$(pidof dunst); kill $pid && dunst &
  # sleep 1
  # notify-send -u critical "critical"; notify-send -u normal "normal"; notify-send -u low "low"
}

apply_xob() {
  local file="$programs"/xob/styles.cfg
  _replace_xob() {
    sed -i -r "$1s/=.*/= \"$2\";/" $file
  }
  # volume
  _replace_xob 25 $colors_foreground
  _replace_xob 26 $colors_background
  _replace_xob 27 $colors_foreground
  _replace_xob 30 $colors_bright_black
  _replace_xob 31 $colors_background
  _replace_xob 32 $colors_bright_black
  # brightness
  _replace_xob 59 $colors_yellow
  _replace_xob 60 $colors_background
  _replace_xob 61 $colors_yellow
  _replace_xob 64 $colors_bright_black
  _replace_xob 65 $colors_background
  _replace_xob 66 $colors_bright_black
  nohup xob_server >/dev/null 2>&1
}

apply_rofi() {
  local file="$programs"/rofi/encus.rasi
  _replace_rofi() {
    sed -i -r "$1s/\:.*/: $2;/" $file
  }
  _replace_rofi 2 $colors_background;
  _replace_rofi 4 $colors_bright_black;
  _replace_rofi 5 $colors_foreground;
  _replace_rofi 7 $colors_foreground;
  _replace_rofi 8 $colors_background;
}

toggle_gnome() {
  declare mode
  case "$selected" in
    *"light"*|*"lotus"*|*"day"*|*"latte"*|*"dawn"*)
      mode="default"
    ;;
    *)
      mode="prefer-dark"
    ;;
  esac
  gsettings set org.gnome.desktop.interface color-scheme "$mode"

  case "$mode" in
    default) mode=0
    ;;
    prefer-dark) mode=1
    ;;
  esac
  sed -i "0,/gtk-application-prefer-dark-theme/ s/=.*/=$mode/" ~/.config/gtk-3.0/settings.ini

  caffeine kill && nohup caffeine start >/dev/null 2>&1
}

apply_alacritty
apply_nvim
apply_polybar
apply_bspwm
apply_dunst
apply_xob
apply_rofi
toggle_gnome
exit
