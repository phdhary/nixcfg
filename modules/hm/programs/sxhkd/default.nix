{ config, lib, namespace, pkgs, ... }:
let
  cfg = config.${namespace}.programs.sxhkd;
  inherit (config.${namespace}.lib) runtimePath;
  inherit (config.lib.file) mkOutOfStoreSymlink;
in {
  options.${namespace}.programs.sxhkd = {
    enable = lib.mkEnableOption "sxhkd";
    enable-bspwm-mappings = lib.mkEnableOption "bspwm mappings";
    enable-i3-mappings = lib.mkEnableOption "i3 mappings";
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.sxhkd;
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
    xdg.configFile = lib.mkMerge [
      {
        "sxhkd/sxhkdrc.common".source =
          mkOutOfStoreSymlink (runtimePath ./sxhkdrc.common);
      }
      (lib.optionalAttrs cfg.enable-bspwm-mappings {
        "sxhkd/sxhkdrc.bspwm".source =
          mkOutOfStoreSymlink (runtimePath ./sxhkdrc.bspwm);
      })
      (lib.optionalAttrs cfg.enable-i3-mappings {
        "sxhkd/sxhkdrc.i3".source =
          mkOutOfStoreSymlink (runtimePath ./sxhkdrc.i3);
      })
    ];
  };
}
