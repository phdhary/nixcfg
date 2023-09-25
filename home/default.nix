{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./programs
    ./shells
    ./terminal-emulators
    ./wm
    ./fonts.nix
  ];

  home.packages = with pkgs; [
    alejandra
    amberol
    dbeaver
    dynamic-wallpaper
    eartag
    easyeffects
    eyedropper
    fragments
    gnome-extension-manager
    gnome-solanum
    insomnia
    mousai
    nixd
    nixgl.nixGLIntel
    pfetch
    textpieces
    unstable.obsidian
    wormhole-rs
  ];

  nixpkgs.overlays = import ../overlays {inherit inputs config lib;};

  xdg.systemDirs.data = let
    inherit (config.home) homeDirectory;
  in [
    "${homeDirectory}/.nix-profile/share" # to make .desktop files detected by DE
  ];

  programs.home-manager.enable = true;
}
