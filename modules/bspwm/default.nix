{ config, lib, namespace, pkgs, ... }:
let
  cfg = config.${namespace}.bspwm;
  inherit (pkgs.lib) mkConfigSymlinkFromList;
in {
  options.${namespace}.bspwm = { enable = lib.mkEnableOption "bspwm"; };
  config = lib.mkIf cfg.enable {
    # xsession.enable = true;
    home.packages = with pkgs; [ polybarFull bspwm sxhkd ];
    home.file = mkConfigSymlinkFromList {
      relativePath = "modules/bspwm";
      paths = [ "bspwm/" "sxhkd/" ];
    };
  };
}

