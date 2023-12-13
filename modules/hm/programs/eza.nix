{ config, namespace, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.programs.eza;
in {
  options.${namespace}.programs.eza = {
    enable = mkEnableOption "eza";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.nixpkgs-23-11.eza ];
    home.shellAliases = {
      ls = "${pkgs.nixpkgs-23-11.eza}/bin/eza --icons --colour=always";
    };
  };
}
