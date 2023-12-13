#!/bin/bash

redshift() {
  declare -A choices
  choices[reset]=;
  choices[red]=2500
  choices[yellow]=4500
  selected=$(printf '%s\n' "${!choices[@]}" | rofi -dmenu -no-custom -p "redshift  " -matching fuzzy)
  test "$selected" = "" && exit
  test "$selected" = "reset" && @redshift@ -x >/dev/null && exit
  @redshift@ -P -O "${choices["$selected"]}" >/dev/null
}

audio() {
  choices=("speaker" "microphone")
  selected=$(printf '%s\n' "${choices[@]}" | rofi -dmenu -no-custom -p "pulse select  " -matching fuzzy)
  test "$selected" = "" && exit
  case "$selected" in
    "${choices[0]}") @rofi-pulse-select@ sink ;;
    "${choices[1]}") @rofi-pulse-select@ source ;;
  esac
}

clipboard() {
  choices=("clipmenu" "delete entry")
  selected=$(printf '%s\n' "${choices[@]}" | rofi -dmenu -no-custom -p " " -matching fuzzy)
  case "$selected" in
    "${choices[0]}") CM_LAUNCHER=rofi clipmenu -p "clipboard  " -theme encus ;;
    "${choices[1]}") CM_OUTPUT_CLIP=1 CM_LAUNCHER=rofi clipmenu -p "clipboard  " -theme encus | clipdel -d;;
  esac
}

choices=("monitor" "audio" "redshift" "clipboard" "bluetooth")
# while :
# do
  selected=$(printf '%s\n' "${choices[@]}" | rofi -dmenu -no-custom -p "utility  " -matching fuzzy)
  test "$selected" = "" && exit
  case "$selected" in
    "${choices[0]}") ~/.config/nixcfg/packages/scripts/monitor_setup.sh ;;
    "${choices[1]}") audio ;;
    "${choices[2]}") redshift ;;
    "${choices[3]}") clipboard ;;
    "${choices[4]}") @rofi-bluetooth@ ;;
  esac
# done
