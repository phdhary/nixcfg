{
  config,
  pkgs,
  namespace,
  ...
}: {
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
    macchina
    mousai
    nixd
    nixgl.nixGLIntel
    textpieces
    unstable.obsidian
    wormhole-rs
  ];

  xdg.systemDirs.data = let
    inherit (config.home) homeDirectory;
  in [
    "${homeDirectory}/.nix-profile/share" # to make .desktop files detected by DE
  ];

  programs.home-manager.enable = true;

  ${namespace} = let
    inherit (config.${namespace}) enabled disabled;
  in {
    wezterm = enabled;
    kitty = enabled;
    vscode = enabled;
    # shells=enabled;
    window-managers-symlink = enabled;
    firefox = disabled;
  };
}
