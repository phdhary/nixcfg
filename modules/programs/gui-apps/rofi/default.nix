{ config, lib, namespace, pkgs, ... }:
let
  cfg = config.${namespace}.programs.gui-apps.rofi;
  inherit (pkgs.lib) mkConfigSymlinkFromList;
in {
  options.${namespace}.programs.gui-apps.rofi = {
    enable = lib.mkEnableOption "rofi";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      rofi
      rofi-power-menu
      rofi-bluetooth
      rofi-pulse-select
      # rofi-wayland
    ];
    home.file = mkConfigSymlinkFromList {
      relativePath = "modules/programs/gui-apps";
      paths = [ "rofi/encus.rasi" "rofi/config.rasi" ];
    };
  };
}
