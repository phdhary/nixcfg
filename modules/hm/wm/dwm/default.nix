{ config, lib, namespace, pkgs, packages, ... }:
let cfg = config.${namespace}.wm.dwm;
in {
  options.${namespace}.wm.dwm.enable = lib.mkEnableOption "dwm";
  config = lib.mkIf cfg.enable {
    home.packages = with packages;
      [ dwm slstatus ] ++ (with pkgs; [
        caffeine-ng
        nitrogen
        # networkmanagerapplet
        # some polkit
      ]);
    ${namespace}.programs = {
      dunst.enable = true;
      picom.enable = true;
      xob.enable = true;
      sxhkd.enable = true;
    };
  };
}
