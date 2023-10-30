{ config, lib, namespace, pkgs, ... }:
let
  cfg = config.${namespace}.programs.picom;
  inherit (config.${namespace}.lib) runtimePath wrapWithNixGLIntel;
  inherit (config.lib.file) mkOutOfStoreSymlink;
  wrapped_picom = wrapWithNixGLIntel "wrapped_picom" "picom";
  picom_joined = pkgs.symlinkJoin {
    name = "joined_picom";
    paths = [ wrapped_picom pkgs.picom ];
  };
in {
  options.${namespace}.programs.picom = {
    enable = lib.mkEnableOption "picom";
    package = lib.mkOption {
      type = lib.types.package;
      default = picom_joined;
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
    xdg.configFile."picom/picom.conf".source =
      mkOutOfStoreSymlink (runtimePath ./picom.conf);
  };
}
