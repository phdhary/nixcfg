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
  ];

  home.packages = with pkgs; [
    alejandra
    wormhole-rs
    nixd
  ];

  nixpkgs.overlays = import ../overlays {inherit inputs config lib;};

  xdg.systemDirs.data = let
    inherit (config.home) homeDirectory;
  in [
    "${homeDirectory}/.nix-profile/share" # to make .desktop files detected by DE
  ];

  programs.home-manager.enable = true;
}
