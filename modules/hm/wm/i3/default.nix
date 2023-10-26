{ config, lib, namespace, pkgs, ... }:
let
  cfg = config.${namespace}.wm.i3;
  inherit (config.${namespace}.lib) mkXdgConfigLink;
in {
  options.${namespace}.wm.i3.enable = lib.mkEnableOption "i3";
  config = lib.mkIf cfg.enable {
    # xsession.windowManager.i3.enable = true;
    xdg.configFile = mkXdgConfigLink {
      relativePath = "modules/hm/wm";
      directory = "i3";
      paths = [ "common.conf" "config" ];
    };
    ${namespace}.programs = {
      dunst.enable = true;
      picom.enable = true;
      polybar.enable = true;
      sxhkd = {
        enable = true;
        enable-i3-mappings = true;
      };
      xob.enable = true;
    };
  };
}
