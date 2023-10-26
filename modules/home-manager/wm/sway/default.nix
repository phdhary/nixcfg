{ config, lib, namespace, pkgs, ... }:
let
  cfg = config.${namespace}.wm.sway;
  inherit (config.${namespace}.lib) mkXdgConfigLink;
in {
  options.${namespace}.wm.sway.enable = lib.mkEnableOption "sway";
  config = lib.mkIf cfg.enable {
    # wayland.windowManager.sway.enable=true;
    xdg.configFile = mkXdgConfigLink {
      relativePath = "modules/home-manager/wm";
      directory = "sway";
      paths = [ "config" ];
    };
    ${namespace}.programs = {
      dunst.enable = true;
      picom.enable = true;
      polybar.enable = true;
      sxhkd = {
        enable = true;
        # enable-sway-mappings = true;
      };
      xob.enable = true;
    };
  };
}
