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
    home.activation.generateRofiStateFile =
      lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        target_dir=~/.local/state/rofi
        if [ ! -f $target_dir/current_color.rasi ]; then
          mkdir -p $target_dir
          cp ${builtins.toPath ./current_color.rasi} $target_dir/current_color.rasi
        fi
      '';
    xdg.configFile = {
      "rofi/encus.rasi".source = mkOutOfStoreSymlink (runtimePath ./encus.rasi);
      "rofi/dmenu.rasi".source = mkOutOfStoreSymlink (runtimePath ./dmenu.rasi);
      "rofi/config.rasi".source =
        mkOutOfStoreSymlink (runtimePath ./config.rasi);
    };
  };
}
