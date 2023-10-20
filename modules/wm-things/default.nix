{ config, lib, namespace, pkgs, packages, ... }:
let cfg = config.${namespace}.wm-things;
in {
  options.${namespace}.wm-things = {
    enable = lib.mkEnableOption "window manager things";
  };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
      [
        # betterlockscreen
        avizo
        bspwm
        bsp-layout
        eww
        dunst
        picom
        polybarFull
        # pywal
        sxhkd
        xtitle
      ] ++ (with packages; [ xobVolume xobBrightness xobServer ]);
    home.file = pkgs.lib.mkConfigSymlinkFromList {
      relativePath = "modules/wm-things";
      paths = [
        "avizo/config.ini"
        "bspwm/"
        "xob/"
        "dunst/"
        "i3/common.conf"
        "i3/config"
        "i3status-rust/config.toml"
        "i3status-rust/themes/roso.toml"
        "picom/picom.conf"
        "polybar/config.ini"
        "polybar/launch.sh"
        "pop-shell/config.json"
        "sway/config"
        "swaylock/config"
        "swaynag/config"
        "sxhkd/"
        "wofi/config"
        "wofi/style.css"
      ];
    };
  };
}
