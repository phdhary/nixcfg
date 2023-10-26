{ config, lib, namespace, pkgs, ... }:
let
  cfg = config.${namespace}.wm.bspwm;
  inherit (config.${namespace}.lib) mkXdgConfigLink;
in {
  options.${namespace}.wm.bspwm.enable = lib.mkEnableOption "bspwm";
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ bspwm bsp-layout xtitle ];
    xdg.configFile = mkXdgConfigLink {
      relativePath = "modules/hm/wm";
      directory = "bspwm";
      paths = [
        "noswallow"
        "bspwmrc"
        "terminals"
        "scripts/bspad.sh"
        "scripts/bspswallow.sh"
        "scripts/external_rule.sh"
        "scripts/monitor.sh"
        "scripts/monitor_options.sh"
        "scripts/presel.sh"
        "scripts/swap_desktop.sh"
      ];
    };
    ${namespace}.programs = {
      dunst.enable = true;
      picom.enable = true;
      polybar.enable = true;
      sxhkd = {
        enable = true;
        enable-bspwm-mappings = true;
      };
      xob.enable = true;
    };
  };
}
