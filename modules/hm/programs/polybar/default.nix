{ config, lib, namespace, pkgs, ... }:
let
  cfg = config.${namespace}.programs.polybar;
  inherit (config.${namespace}.lib) recursiveSymlink;
  inherit (lib) hasSuffix;

in {
  options.${namespace}.programs.polybar = {
    enable = lib.mkEnableOption "polybar";
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.polybarFull;
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
    xdg.configFile = recursiveSymlink {
      directory = "polybar";
      path = ./.;
      filter = list:
        builtins.filter (f: (!hasSuffix ".nix" f)) list;
    };
  };
}
