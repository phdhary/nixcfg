{ config, lib, namespace, pkgs, ... }:
let cfg = config.${namespace}.programs.gui-apps.rofi;
in {
  options.${namespace}.programs.gui-apps.rofi = {
    enable = lib.mkEnableOption "rofi";
  };

  config = lib.mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      terminal = "wrapped_wezterm";
      theme = "DarkBlue";
      extraConfig = {
        modi = "drun,run,window";
        drun-display-format = "{icon} {name}";
        show-icons = true;
      };
    };
    home.packages = with pkgs; [
      rofi-power-menu
      rofi-bluetooth
      rofi-pulse-select
    ];
  };
}
