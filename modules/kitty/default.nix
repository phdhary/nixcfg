{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (pkgs.lib) mkConfigSymlink;
  cfg = config.${namespace}.kitty;
in {
  options.${namespace}.kitty = {
    enable = mkEnableOption "kitty terminal emulator";
  };

  config = mkIf cfg.enable {
    home.file = mkConfigSymlink "/modules/" [
      "kitty/kitty.conf"
      "kitty/scrollback-pager/init.lua"
      "kitty/themes/"
    ];
  };
}
