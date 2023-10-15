{ config, lib, namespace, pkgs, ... }:
let cfg = config.${namespace}.bspwm;
in {
  options.${namespace}.bspwm = { enable = lib.mkEnableOption "bspwm"; };
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.polybarFull ];
    xsession.enable = true;
    xsession.windowManager.bspwm = {
      enable = true;
      # alwaysResetDesktops
      # extraConfig
      # extraConfigEarly
      monitors = {
        eDP-1 = [ "I" "II" "III" "IV" "V" "VI" "VII" "VIII" "IX" "X" ];
      };
      # package
      rules = {
        Gimp = {
          desktop = "^8";
          state = "floating";
          follow = true;
        };
        firefox-nightly.state = "tiled";
        ncmpcpp.state = "floating";
        Screenkey.manage = false;
      };
      settings = {
        border_width = 2;
        window_gap = 12;
        split_ratio = 0.52;
        borderless_monocle = true;
        gapless_monocle = true;
      };
      startupPrograms = [
        "sxhkd"
        "picom --config $HOME/.config/i3/picom.conf"
        "nm-applet --indicator"
        ''
          feh --bg-fill $(gsettings get org.gnome.desktop.background picture-uri | sed 's/file:\/\///' | tr -d "'")''
        "polybar"
        # "default_wall"
        # "flameshot"
        # "dunst"
        # "sleep 2s;polybar -q main"
      ];
    };
    services.sxhkd = {
      enable = true;
      # package
      # extraConfig
      # extraOptions
      # extraPath
      keybindings = {
        "XF86AudioLowerVolume" = "volumectl -u down";
        "XF86AudioRaiseVolume" = "volumectl -u up";
        "XF86AudioMute" = "volumectl toggle-mute";
        "XF86AudioMicMute" = "volumectl -m toggle-mute";
        "XF86MonBrightnessUp" =
          ''lightctl = "$(light -G | awk '{ print int(($1 + .72) * 1.4) }')"'';
        "XF86MonBrightnessDown" =
          ''lightctl = "$(light -G | awk '{ print int($1 / 1.4) }')"'';
        "super + Return" = "wrapped_wezterm";
        "super + d" = "rofi -theme dmenu -show";
        "super + Escape" = "pkill -USR1 -x sxhkd";
        "super + b" = "firefox-nightly";
        "super + u" = ''wrapped_wezterm --class="ncmpcpp" ncmpcpp'';
        "super + f" = "wrapped_wezterm yazi";
        "super + shift + e" =
          "rofi -show power-menu -modi power-menu:rofi-power-menu";
        # quit/restart bspwm
        "super + alt + {q,r}" = "bspc {quit,wm -r}";
        # close and kill
        # "super + {_,shift + }w" = "bspc node -{c,k}";
        "super + q" = "bspc node -c";
        # alternate between the tiled and monocle layout
        "super + m" = "bspc desktop -l next";
        # send the newest marked node to the newest preselected node
        "super + y" =
          "bspc node newest.marked.local -n newest.!automatic.local";
        # swap the current node and the biggest window
        "super + g" = "bspc node -s biggest.window";
        #
        # state/flags
        #
        # set the window state
        "super + {t,shift + t,s,f}" =
          "bspc node -t {tiled,pseudo_tiled,floating,fullscreen}";
        # set the node flags
        "super + ctrl + {m,x,y,z}" =
          "bspc node -g {marked,locked,sticky,private}";
        #
        # focus/swap
        #
        # focus the node in the given direction
        "super + {_,shift + }{h,j,k,l}" =
          "bspc node -{f,s} {west,south,north,east}";
        # focus the node for the given path jump
        "super + {p,b,comma,period}" =
          "bspc node -f @{parent,brother,first,second}";
        # focus the next/previous window in the current desktop
        "super + {_,shift + }c" =
          "bspc node -f {next,prev}.local.!hidden.window";
        # focus the next/previous desktop in the current monitor
        "super + bracket{left,right}" = "bspc desktop -f {prev,next}.local";
        # focus the last node/desktop
        "super + {grave,Tab}" = "bspc {node,desktop} -f last";
        # focus the older or newer node in the focus history
        "super + {o,i}" =
          "\n  bspc wm -h off; \n  bspc node {older,newer} -f; \n  bspc wm -h on\n  ";
        # focus or send to the given desktop
        "super + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1-9,10}'";
        #
        # preselect
        #
        # preselect the direction
        "super + ctrl + {h,j,k,l}" = "bspc node -p {west,south,north,east}";
        # preselect the ratio
        "super + ctrl + {1-9}" = "bspc node -o 0.{1-9}";
        # cancel the preselection for the focused node
        "super + ctrl + space" = "bspc node -p cancel";
        # cancel the preselection for the focused desktop
        "super + ctrl + shift + space" =
          "bspc query -N -d | xargs -I id -n 1 bspc node id -p cancel";
        #
        # move/resize
        #
        # expand a window by moving one of its side outward
        "super + alt + {h,j,k,l}" =
          "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";
        # contract a window by moving one of its side inward
        "super + alt + shift + {h,j,k,l}" =
          "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";
        # move a floating window
        "super + {Left,Down,Up,Right}" = "bspc node -v {-20 0,0 20,0 -20,20 0}";
      };
    };
  };
}

