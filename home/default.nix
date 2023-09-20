{
  config,
  pkgs,
  ...
}: let
  inherit (config.home) homeDirectory;
in {
  imports = [
    ./programs
    ./shells
    ./wm
    ./terminal-emulators
  ];

  home.packages = with pkgs; [
    alejandra
    wormhole-rs
    nixd
  ];

  xdg.systemDirs.data = [
    "${homeDirectory}/.nix-profile/share" # to make .desktop files detected by DE
  ];

  programs.home-manager.enable = true;
}
