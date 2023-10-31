list=(
"ayu-dark"
"ayu-light"
"ayu-mirage"
"carbonfox"
"catppuccin-frappe" 
"catppuccin-latte" 
"catppuccin-macchiato"
"catppuccin-mocha" 
"dawnfox"
"dayfox"
"duskfox"
"kanagawa-dragon"
"kanagawa-lotus"
"kanagawa-wave"
"moonfly"
"nightfly"
"nightfox"
"nordfox"
"rose-pine-dawn"
"rose-pine-main"
"rose-pine-moon"
"terafox"
"tokyonight-day"
"tokyonight-moon"
"tokyonight-night"
"tokyonight-storm"
)

current=$(cat ~/.config/alacritty/current_theme.yml | tail -1 | awk '{print $2}' | cut -c28- | sed 's/.yml//')

# selected=$(printf "%s\n" "${list[@]}" | fzf --layout=reverse)
selected=$(printf "%s\n" "${list[@]}" | rofi -dmenu -p "($current)" -matching fuzzy -theme-str '#window { width: 25%; }')

if [ -z "$selected" ]; then
  exit
fi

echo "selected: $selected"

sadd() {
  sed -i "s/.*$1.*/$2/" $3
}

sadd_first_only() {
  sed -i "0,/$1/ s/.*$1.*/$2/" $3
}

sadd_line() {
  sed -i "$1s/.*$2.*/$3/" $4
}

get_first_match() {
  grep -i "$1" ~/.config/alacritty/themes/"$selected".yml | head -1 | awk '{print $2}' | sed 's/\"//g' | sed "s/'//g"
}

get_second_match() {
  grep -i "$1" ~/.config/alacritty/themes/"$selected".yml | head -2 | tail -1 | awk '{print $2}' | sed 's/\"//g' | sed "s/'//g"
}

background=$(get_first_match "background")
background_alt=$(get_second_match "black")
foreground=$(get_first_match "foreground")
primary=$(get_first_match "blue")
secondary=$(get_first_match "green")
alert=$(get_first_match "red")
disabled=$(get_second_match "black")
yellow=$(get_first_match "yellow")

apply_alacritty() {
  local file=~/.config/nixcfg/modules/hm/programs/alacritty/current_theme.yml
  sadd "config" "  - ~\/.config\/alacritty\/themes\/$selected.yml" $file
}

apply_nvim() {
  local file=~/.config/nixcfg/modules/hm/programs/neovim/nvim/lua/user/config.lua
  sadd "colorscheme" "\tcolorscheme = \"$selected\"," $file
  killall -USR1 nvim
}

apply_polybar() {
  local file=~/.config/nixcfg/modules/hm/programs/polybar/config.ini
  sadd_first_only "background" "background = $background" $file
  sadd_first_only "background\-alt" "background\-alt = $background_alt" $file
  sadd_first_only "foreground" "foreground = $foreground" $file
  sadd_first_only "primary" "primary = $foreground" $file
  sadd_first_only "secondary" "secondary = $secondary" $file
  sadd_first_only "alert" "alert = $alert" $file
  sadd_first_only "disabled" "disabled = $disabled" $file
  # polybar-msg cmd restart
}

apply_bspwm() {
  local file=~/.config/nixcfg/modules/hm/wm/bspwm/bspwmrc
  sadd_first_only "normal_border_color" "bspc config 'normal_border_color'     '$background_alt'" $file
  sadd_first_only "focused_border_color" "bspc config 'focused_border_color'    '$primary'" $file

  bspc config 'normal_border_color' "$background_alt"
  bspc config 'focused_border_color' "$primary"
}

apply_dunst() {
  local file=~/.config/nixcfg/modules/hm/programs/dunst/dunstrc
  _replace_dunst() {
    sed -i -r "$1s/=.*/= \"$2\"/" $file
  }
  _replace_dunst 316 $background_alt
  _replace_dunst 317 $foreground
  _replace_dunst 323 $primary
  _replace_dunst 325 $background
  _replace_dunst 331 $alert
  _replace_dunst 332 $background
  pid=$(pidof dunst); kill $pid && dunst &
  # sleep 1
  # notify-send -u critical "critical"; notify-send -u normal "normal"; notify-send -u low "low"
}

apply_xob() {
  local file=~/.config/nixcfg/modules/hm/programs/xob/styles.cfg
  _replace_xob() {
    sed -i -r "$1s/=.*/= \"$2\";/" $file
  }
  # volume
  _replace_xob 25 $foreground
  _replace_xob 26 $background
  _replace_xob 27 $foreground
  _replace_xob 30 $background_alt
  _replace_xob 31 $background
  _replace_xob 32 $background_alt
  # brightness
  _replace_xob 59 $yellow
  _replace_xob 60 $background
  _replace_xob 61 $yellow
  _replace_xob 64 $background_alt
  _replace_xob 65 $background
  _replace_xob 66 $background_alt
  nohup xob_server >/dev/null 2>&1
}

apply_rofi() {
  local file=~/.config/nixcfg/modules/hm/programs/rofi/encus.rasi
  _replace_rofi() {
    sed -i -r "$1s/\:.*/: $2;/" $file
  }
  _replace_rofi 2 $background;
  _replace_rofi 4 $background_alt;
  _replace_rofi 5 $foreground;
  _replace_rofi 7 $foreground;
  _replace_rofi 8 $background;
}

toggle_gnome() {
  case "$selected" in
    *"light"*|*"lotus"*|*"day"*|*"latte"*|*"dawn"*)
      gsettings set org.gnome.desktop.interface color-scheme "default"
    ;;
    *)
      gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
    ;;
  esac
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
