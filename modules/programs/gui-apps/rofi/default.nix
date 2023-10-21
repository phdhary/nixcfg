{ config, lib, namespace, pkgs, ... }:
let
  cfg = config.${namespace}.programs.gui-apps.rofi;
  inherit (pkgs.lib) mkConfigSymlinkFromList;
in {
  options.${namespace}.programs.gui-apps.rofi = {
    enable = lib.mkEnableOption "rofi";
  };

  config = lib.mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      terminal = "wrapped_wezterm";
      theme = "${config.xdg.configHome}/rofi/theme.rasi";
      extraConfig = {
        modi = "window,drun,run";
        drun-display-format = "{icon} {name}";
        show-icons = true;
        font = "Inter";
        display-drun = "Applications:";
        display-window = "Windows:";
      };
    };
    home.packages = with pkgs; [
      rofi-power-menu
      rofi-bluetooth
      rofi-pulse-select
      # rofi-wayland
    ];
    home.file = mkConfigSymlinkFromList {
      relativePath = "modules/programs/gui-apps";
      paths = [ "rofi/theme.rasi" ];
    };
  };
}
