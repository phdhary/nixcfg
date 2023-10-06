{ config, namespace, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.programs.cli-apps.eza;
in {
  options.${namespace}.programs.cli-apps.eza = {
    enable = mkEnableOption "eza";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.unstable.eza ];
    home.shellAliases = { ls = "eza --icons"; };
  };
}
