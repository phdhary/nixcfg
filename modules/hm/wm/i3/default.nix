{ config, lib, namespace, pkgs, ... }:
let
  cfg = config.${namespace}.wm.i3;
  inherit (config.${namespace}.lib) runtimePath;
  inherit (config.lib.file) mkOutOfStoreSymlink;
in {
  options.${namespace}.wm.i3.enable = lib.mkEnableOption "i3";
  config = lib.mkIf cfg.enable {
    # xsession.windowManager.i3.enable=true;
    xdg.configFile = {
      "i3/config".source = mkOutOfStoreSymlink (runtimePath ./config);
      "i3/common.conf".source = mkOutOfStoreSymlink (runtimePath ./config);
    };
    ${namespace}.programs = {
      dunst.enable = true;
      picom.enable = true;
      polybar.enable = true;
      sxhkd = {
        enable = true;
        enable-i3-mappings = true;
      };
      xob.enable = true;
    };
  };
}
