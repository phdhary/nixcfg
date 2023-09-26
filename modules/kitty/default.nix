{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (pkgs.lib) makeConfigSymlink;
  cfg = config.${namespace}.kitty;
  parentPath = "/modules/";
in {
  options.${namespace}.kitty = {
    enable = mkEnableOption "kitty terminal emulator";
  };

  config = mkIf cfg.enable {
    home.file =
      makeConfigSymlink parentPath "kitty/kitty.conf"
      // makeConfigSymlink parentPath "kitty/scrollback-pager/init.lua"
      // makeConfigSymlink parentPath "kitty/themes/";
  };
}
