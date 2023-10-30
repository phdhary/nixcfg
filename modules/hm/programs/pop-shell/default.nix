{ config, namespace, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.${namespace}.lib) runtimePath;
  inherit (config.lib.file) mkOutOfStoreSymlink;
  cfg = config.${namespace}.programs.pop-shell;
in {
  options.${namespace}.programs.pop-shell = {
    enable = mkEnableOption "pop-shell";
  };

  config = mkIf cfg.enable {
    # home.packages= [pkgs.gnomeExtensions.pop-shell];
    xdg.configFile."pop-shell/config.json".source =
      mkOutOfStoreSymlink (runtimePath ./config.json);
  };
}
