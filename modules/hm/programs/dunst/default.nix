{ config, lib, namespace, pkgs, ... }:
let
  cfg = config.${namespace}.programs.dunst;
  inherit (config.${namespace}.lib) runtimePath;
  inherit (config.lib.file) mkOutOfStoreSymlink;
in {
  options.${namespace}.programs.dunst = {
    enable = lib.mkEnableOption "dunst";
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.dunst;
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
    xdg.configFile."dunst/dunstrc".source =
      mkOutOfStoreSymlink (runtimePath ./dunstrc);
  };
}
