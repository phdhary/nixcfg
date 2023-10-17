{ config, lib, namespace, pkgs, ... }:
let cfg = config.${namespace}.wms-symlink;
in {
  options.${namespace}.wms-symlink = {
    enable = lib.mkEnableOption "window managers symlink";
  };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ 
      # betterlockscreen
      picom
    ];
    home.file = pkgs.lib.mkConfigSymlinkFromList {
      relativePath = "modules/wms-symlink";
      paths = [
        "avizo/config.ini"
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
        "wofi/config"
        "wofi/style.css"
      ];
    };
  };
}
