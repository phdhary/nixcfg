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

  home.packages = with pkgs;
    [
      alejandra
      amberol
      gnome-solanum
      insomnia
      mousai
      pfetch
      nixd
      nixgl.nixGLIntel
      unstable.obsidian
      wormhole-rs
    ]
    ++ [
      fira-code
      ibm-plex
      jetbrains-mono
      source-code-pro
      (unstable.nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
    ];

  nixpkgs.overlays = import ../overlays {inherit inputs config lib;};

  xdg.systemDirs.data = let
    inherit (config.home) homeDirectory;
  in [
    "${homeDirectory}/.nix-profile/share" # to make .desktop files detected by DE
  ];

  programs.home-manager.enable = true;
}
