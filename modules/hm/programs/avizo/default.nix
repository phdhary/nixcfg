{ config, lib, namespace, pkgs, ... }:
let
  cfg = config.${namespace}.programs.avizo;
  inherit (config.${namespace}.lib) runtimePath;
  inherit (config.lib.file) mkOutOfStoreSymlink;
in {
  options.${namespace}.programs.avizo = {
    enable = lib.mkEnableOption "avizo";
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.avizo;
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
    xdg.configFile."avizo/config.ini".source =
      mkOutOfStoreSymlink (runtimePath ./config.ini);
  };
}
