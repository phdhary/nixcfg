{ config, lib, namespace, pkgs, ... }:
let
  cfg = config.${namespace}.wm.sway;
  inherit (config.${namespace}.lib) runtimePath;
  inherit (config.lib.file) mkOutOfStoreSymlink;
in {
  options.${namespace}.wm.sway.enable = lib.mkEnableOption "sway";
  config = lib.mkIf cfg.enable {
    # wayland.windowManager.sway.enable=true;
    xdg.configFile."sway/config".source =
      mkOutOfStoreSymlink (runtimePath ./config);

    ${namespace}.programs = {
      dunst.enable = true;
      picom.enable = true;
      polybar.enable = true;
      sxhkd = {
        enable = true;
        # enable-sway-mappings = true;
      };
      xob.enable = true;
    };
  };
}
