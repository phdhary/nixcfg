{ config, lib, namespace, pkgs, ... }:
let
  cfg = config.${namespace}.programs.polybar;
  inherit (config.${namespace}.lib) mkXdgConfigLink;
in {
  options.${namespace}.programs.polybar.enable = lib.mkEnableOption "polybar";
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ polybarFull ];
    xdg.configFile = mkXdgConfigLink {
      relativePath = "modules/home-manager/programs";
      directory = "polybar";
      paths = [ "config.ini" "launch.sh" ];
    };
  };
}
