{ config, lib, namespace, pkgs, ... }:
let
  cfg = config.${namespace}.programs.dunst;
  inherit (config.${namespace}.lib) mkXdgConfigLink;
in {
  options.${namespace}.programs.dunst = {
    enable = lib.mkEnableOption "dunst";
  };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ dunst ];
    xdg.configFile = mkXdgConfigLink {
      relativePath = "modules/hm/programs";
      directory = "dunst";
      paths = [ "dunstrc" ];
    };
  };
}
