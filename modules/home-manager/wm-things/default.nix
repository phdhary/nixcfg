{ config, lib, namespace, pkgs, packages, ... }:
let
  cfg = config.${namespace}.wm-things;
  wrapped_picom = pkgs.writeShellScriptBin "wrapped_picom" ''
    if command -v "nixGLIntel" &> /dev/null; then
        nixGLIntel picom "$@"
    else
        picom "$@"
    fi
  '';
  picom_joined = pkgs.symlinkJoin {
    name = "joined_picom";
    paths = [ wrapped_picom pkgs.picom ];
  };
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
        # picom
        picom_joined
        polybarFull
        # pywal
        sxhkd
        xtitle
      ] ++ (with packages; [ xob_volume xob_brightness xob_server ]);
    home.file = pkgs.lib.mkConfigSymlinkFromList {
      relativePath = "modules/home-manager/wm-things";
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
