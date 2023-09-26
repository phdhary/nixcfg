{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (pkgs.lib) mkConfigSymlink;
  cfg = config.${namespace}.wms-symlink;
in {
  options.${namespace}.wms-symlink = {
    enable = mkEnableOption "window managers symlink";
  };
  config = mkIf cfg.enable {
    home.file =
      mkConfigSymlink "/modules/wms-symlink/"
      [
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
}
