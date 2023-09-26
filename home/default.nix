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
    mousai
    nixd
    nixgl.nixGLIntel
    pfetch
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

  ${namespace} = {
    wezterm.enable = true;
    kitty.enable = true;
    vscode.enable = true;
    # shells.enable = true;
    window-managers-symlink.enable = true;
  };
}
