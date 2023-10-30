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

selected=$(printf "%s\n" "${list[@]}" | fzf)

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
  # sed -i "$1,/$2/ s/.*$2.*/$3/" $4
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
disabled=$(get_first_match "white")

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
  sadd_first_only "primary" "primary = $primary" $file
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
  sadd_line 316 "background" "    background = \"$background_alt\"" $file
  sadd_line 317 "foreground" "    foreground = \"$disabled\"" $file
  sadd_line 323 "background" "    background = \"$primary\"" $file
  sadd_line 325 "foreground" "    foreground = \"$background\"" $file
  sadd_line 331 "background" "    background = \"$alert\"" $file
  sadd_line 332 "foreground" "    foreground = \"$background\"" $file
  pid=$(pidof dunst); kill $pid && dunst &
  # sleep 1
  # notify-send -u critical "critical"; notify-send -u normal "normal"; notify-send -u low "low"
}

apply_alacritty
apply_nvim
apply_polybar
apply_bspwm
apply_dunst
