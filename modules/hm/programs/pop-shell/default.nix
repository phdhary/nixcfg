{ config, namespace, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.${namespace}.lib) mkXdgConfigLink;
  cfg = config.${namespace}.programs.pop-shell;
in {
  options.${namespace}.programs.pop-shell = {
    enable = mkEnableOption "pop-shell";
  };

  config = mkIf cfg.enable {
    # home.packages= [pkgs.gnomeExtensions.pop-shell];
    xdg.configFile = mkXdgConfigLink {
      relativePath = "modules/hm/programs";
      directory = "pop-shell";
      paths = [ "config.json" ];
    };
  };
}
