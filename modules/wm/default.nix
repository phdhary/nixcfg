{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (pkgs.lib) makeConfigSymlink;
  cfg = config.${namespace}.window-managers-symlink;
in {
  options.${namespace}.window-managers-symlink = {
    enable = mkEnableOption "window managers symlink";
  };
  config = mkIf cfg.enable {
    home.file =
      makeConfigSymlink "/modules/wm/"
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
