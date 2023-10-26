{ config, namespace, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.programs.eza;
in {
  options.${namespace}.programs.eza = {
    enable = mkEnableOption "eza";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.unstable-fdd89.eza ];
    home.shellAliases = {
      ls = "${pkgs.unstable-fdd89.eza}/bin/eza --icons --colour=always";
    };
  };
}
