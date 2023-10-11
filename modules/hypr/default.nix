{ config, lib, namespace, pkgs, ... }:
let cfg = config.${namespace}.hyprland;
in {
  options.${namespace}.hyprland = { enable = lib.mkEnableOption "hyprland"; };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      enableNvidiaPatches = true;
      extraConfig = ''
      source=${config.xdg.configHome}/hypr/my-hyprland.conf
      '';
    };
    home.file = pkgs.lib.mkConfigSymlinkFromList {
      relativePath = "modules";
      paths = [ "hypr/my-hyprland.conf" ];
    };
  };
}
