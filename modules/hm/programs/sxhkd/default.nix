{ config, lib, namespace, pkgs, ... }:
let
  cfg = config.${namespace}.programs.sxhkd;
  inherit (config.${namespace}.lib) mkXdgConfigLink;
in {
  options.${namespace}.programs.sxhkd = {
    enable = lib.mkEnableOption "sxhkd";
    enable-bspwm-mappings = lib.mkEnableOption "bspwm mappings";
    enable-i3-mappings = lib.mkEnableOption "i3 mappings";
  };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ sxhkd ];
    xdg.configFile = mkXdgConfigLink {
      relativePath = "modules/hm/programs";
      directory = "sxhkd";
      paths = [ "sxhkdrc.common" ]
        ++ lib.lists.optional cfg.enable-bspwm-mappings "sxhkdrc.bspwm"
        ++ lib.lists.optional cfg.enable-i3-mappings "sxhkdrc.i3";
    };
  };
}
