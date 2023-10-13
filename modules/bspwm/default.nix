{ config, lib, namespace, pkgs, ... }:
let cfg = config.${namespace}.bspwm;
in {
  options.${namespace}.bspwm = { enable = lib.mkEnableOption "bspwm"; };

  config = lib.mkIf cfg.enable {
    # home.file = pkgs.lib.mkConfigSymlinkFromList {
    #   relativePath = "modules";
    #   paths = [
    #     "kitty/themes/"
    #   ];
    # };
    xsession.windowManager.bspwm = {
      enable = true;
      # alwaysResetDesktops
      # extraConfig
      # extraConfigEarly
      # monitors
      # package
      # rules
      # settings
      # startupPrograms
    };
  };
}
