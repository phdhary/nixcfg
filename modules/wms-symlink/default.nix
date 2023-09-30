{ config, lib, namespace, pkgs, ... }:
let cfg = config.${namespace}.wms-symlink;
in {
  options.${namespace}.wms-symlink = {
    enable = lib.mkEnableOption "window managers symlink";
  };
  config = lib.mkIf cfg.enable {
    home.file = pkgs.lib.mkConfigSymlinkFromList {
      relativePath = "/modules/wms-symlink/";
      paths = [
        "avizo/config.ini"
        "i3/common.conf"
        "i3/config"
        "i3/picom.conf"
        "i3status-rust/config.toml"
        "i3status-rust/themes/roso.toml"
        "pop-shell/config.json"
        "rofi/config.rasi"
        "sway/config"
        "swaylock/config"
        "swaynag/config"
        "wofi/config"
        "wofi/style.css"
      ];
    };
  };
}
