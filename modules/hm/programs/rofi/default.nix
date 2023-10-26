{ config, lib, namespace, pkgs, ... }:
let
  cfg = config.${namespace}.programs.rofi;
  inherit (config.${namespace}.lib) mkConfigSymlinkFromList;
in {
  options.${namespace}.programs.rofi = {
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
      relativePath = "modules/hm/programs";
      paths = [ "rofi/encus.rasi" "rofi/config.rasi" ];
    };
  };
}
