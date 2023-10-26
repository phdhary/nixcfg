{ config, lib, namespace, pkgs, ... }:
let
  cfg = config.${namespace}.programs.avizo;
  inherit (config.${namespace}.lib) mkXdgConfigLink;
in {
  options.${namespace}.programs.avizo = {
    enable = lib.mkEnableOption "avizo";
  };
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.avizo ];
    xdg.configFile = mkXdgConfigLink {
      relativePath = "modules/hm/programs";
      directory = "avizo";
      paths = [ "config.ini" ];
    };
  };
}
