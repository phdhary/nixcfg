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
  parentPath = "/modules/wm/";
in {
  options.${namespace}.window-managers-symlink = {
    enable = mkEnableOption "window managers symlink";
  };
  config = mkIf cfg.enable {
    home.file =
      makeConfigSymlink parentPath "avizo/config.ini"
      // makeConfigSymlink parentPath "i3/common.conf"
      // makeConfigSymlink parentPath "i3/config"
      // makeConfigSymlink parentPath "i3/picom.conf"
      // makeConfigSymlink parentPath "i3status-rust/config.toml"
      // makeConfigSymlink parentPath "i3status-rust/themes/roso.toml"
      // makeConfigSymlink parentPath "pop-shell/config.json"
      // makeConfigSymlink parentPath "rofi/config.rasi"
      // makeConfigSymlink parentPath "sway/config"
      // makeConfigSymlink parentPath "swaylock/config"
      // makeConfigSymlink parentPath "swaynag/config"
      // makeConfigSymlink parentPath "wofi/config"
      // makeConfigSymlink parentPath "wofi/style.css";
  };
}
