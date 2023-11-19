{ config, lib, namespace, packages, ... }:
let cfg = config.${namespace}.wm.dwm;
in {
  options.${namespace}.wm.dwm.enable = lib.mkEnableOption "dwm";
  config = lib.mkIf cfg.enable {
    home.packages = [ packages.dwm ];
    ${namespace}.programs = {
      dunst.enable = true;
      picom.enable = true;
      xob.enable = true;
    };
  };
}
