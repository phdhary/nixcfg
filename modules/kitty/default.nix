{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  cfg = config.${namespace}.kitty;
in {
  options.${namespace}.kitty = {
    enable = lib.mkEnableOption "kitty terminal emulator";
  };

  config = lib.mkIf cfg.enable {
    home.file = pkgs.lib.mkConfigSymlinkFromList {
      relativePath = "/modules/";
      paths = [
        "kitty/kitty.conf"
        "kitty/scrollback-pager/init.lua"
        "kitty/themes/"
      ];
    };
  };
}
