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
  ];

  home.packages = with pkgs; [
    alejandra
    wormhole-rs
  ];

  xdg.systemDirs.data = [
    "${homeDirectory}/.nix-profile/share" # to make .desktop files detected by DE
  ];

  programs.home-manager.enable = true;
}
