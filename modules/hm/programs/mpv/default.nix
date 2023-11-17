{ config, namespace, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.${namespace}.lib) runtimePath;
  inherit (config.lib.file) mkOutOfStoreSymlink;
  cfg = config.${namespace}.programs.mpv;
in {
  options.${namespace}.programs.mpv = { enable = mkEnableOption "mpv"; };

  config = mkIf cfg.enable {
    xdg.configFile."mpv/script-opts/uosc.conf".source =
      mkOutOfStoreSymlink (runtimePath ./uosc.conf);
    programs.mpv = {
      enable = true;
      scripts = with pkgs; [ mpvScripts.thumbfast mpvScripts.uosc ];
      bindings = {
        UP = "add volume +2";
        DOWN = "add volume -2";
      };
      config = {
        sub-font = "SF Pro Display";
        osd-bar = "no";
        border = "no";
        # sub-font = "Arial Regular";
        sub-border-size = 1;
        sub-color = "#CDCDCD";
        sub-shadow = 3;
        sub-shadow-color = "#33000000";
        sub-shadow-offset = 2;
        save-position-on-quit = "yes";
      };
    };
  };
}
