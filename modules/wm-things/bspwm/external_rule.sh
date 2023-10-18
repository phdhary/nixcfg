#! /bin/sh

logfile=/tmp/bspwm_external_rules.log
window_id="$1"
window_class="$2"
window_instance="$3"
# window_title="$(xwininfo -id "$window_id" | sed '/^xwininfo/!d ; s,.*"\(.*\)".*,\1,')"
window_type="$(xprop -id "$window_id" _NET_WM_WINDOW_TYPE | sed '/^_NET_WM_WINDOW_TYPE/!d ; s/^.* = \(.*\),.*/\1/')"
window_title="$(xtitle "$window_id")"

case "$window_class" in
  ncmpcpp)
    echo "state=floating";
    ;;
  firefox-nightly) 
    echo "desktop=^1";
    echo "state=tiled";
    echo "follow=off";
    ;;
  btop) 
    echo "desktop=^10";
    echo "state=tiled";
    echo "follow=on";
    ;; 
esac

case "$window_title" in
  Calculator)
    echo "state=floating"
    ;;
esac


case "$window_class" in
  Nitrogen|Avizo-service)
    case "$window_type" in
      *DIALOG* )
        echo "state=floating"
        echo "center=on"
        ;;
      *_NET_WM_WINDOW_TYPE_NOTIFICATION* )
        # echo "manage=off"
        # echo "state=floating"
        ;;
      *_NET_WM_WINDOW_TYPE_NORMAL* )
        echo "state=pseudo_tiled"
        ;;
    esac
    ;;
esac

# case "$window_class" in
#   [Dd]arktable|[Gg]imp )
#     case "$window_type" in
#       *DIALOG* )
#         echo "state=floating"
#         echo "center=on"
#         ;;
#       *_NET_WM_WINDOW_TYPE_NORMAL* )
#         echo "state=fullscreen"
#         ;;
#     esac
#     ;;
# esac

# case "$window_class" in
#   [Ss]cribus )
#     case "$window_title" in
#       Outline|Properties )
#         echo "state=floating"
#         ;;
#       * )
#         echo "state=fullscreen"
#         ;;
#     esac
#     ;;
# esac


echo "Id: $window_id" >> "$logfile"
echo "Class: $window_class" >> "$logfile"
echo "Instance: $window_instance" >> "$logfile"
echo "Title: $window_title" >> "$logfile"
echo "Type: $window_type" >> "$logfile"
echo "---" >> "$logfile"
