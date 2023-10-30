{ config, lib, namespace, pkgs, ... }:
let
  cfg = config.${namespace}.programs.starship;
  inherit (config.${namespace}.lib) runtimePath;
  inherit (config.lib.file) mkOutOfStoreSymlink;
in {
  options.${namespace}.programs.starship = {
    enable = lib.mkEnableOption "starship";
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.unstable.starship;
    };
  };
  config = lib.mkIf cfg.enable {
    programs.starship = {
      inherit (cfg) enable package;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };
    xdg.configFile."starship.toml".source =
      mkOutOfStoreSymlink (runtimePath ./starship.toml);
  };
}
