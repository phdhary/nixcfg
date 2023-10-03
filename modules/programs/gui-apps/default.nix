{ pkgs, ... }: {
  home.packages = with pkgs; [
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
    screenkey
    textpieces
    unstable.obsidian
    wireshark
  ];
}
