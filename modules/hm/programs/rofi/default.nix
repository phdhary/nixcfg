{ config, lib, namespace, pkgs, ... }:
let
  cfg = config.${namespace}.programs.rofi;
  inherit (config.${namespace}.lib) runtimePath;
  inherit (config.lib.file) mkOutOfStoreSymlink;
in {
  options.${namespace}.programs.rofi = { enable = lib.mkEnableOption "rofi"; };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      rofi
      rofi-power-menu
      rofi-bluetooth
      rofi-pulse-select
      # rofi-wayland
    ];
    xdg.configFile = {
      "rofi/encus.rasi".source = mkOutOfStoreSymlink (runtimePath ./encus.rasi);
      "rofi/config.rasi".source =
        mkOutOfStoreSymlink (runtimePath ./config.rasi);
    };
  };
}
