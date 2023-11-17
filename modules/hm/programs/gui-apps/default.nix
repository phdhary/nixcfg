{ config, pkgs, lib, namespace, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.programs;
in {
  options.${namespace}.programs = {
    enable-basic-gui = mkEnableOption "basic";
  };
  config = mkIf cfg.enable-basic-gui {
    home.packages = with pkgs; [
      amberol
      # bottles
      cpu-x
      dbeaver
      dynamic-wallpaper
      eartag
      easyeffects
      eyedropper
      fragments
      insomnia
      mousai
      screenkey
      textpieces
      unstable.obsidian
      unstable-fdd89.gnome-extension-manager
      wireshark
      nitrogen
    ];
  };
}
