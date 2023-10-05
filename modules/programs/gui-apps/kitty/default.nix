{ config, lib, namespace, pkgs, ... }:
let cfg = config.${namespace}.programs.gui-apps.kitty;
in {
  options.${namespace}.programs.gui-apps.kitty = {
    enable = lib.mkEnableOption "kitty terminal emulator";
  };

  config = lib.mkIf cfg.enable {
    home.file = pkgs.lib.mkConfigSymlinkFromList {
      relativePath = "modules/programs/gui-apps";
      paths = [
        "kitty/kitty.conf"
        "kitty/scrollback-pager/init.lua"
        "kitty/themes/"
      ];
    };
  };
}
