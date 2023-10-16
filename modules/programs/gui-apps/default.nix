{ pkgs, ... }: {
  home.packages = with pkgs; [
    amberol
    dbeaver
    dynamic-wallpaper
    eartag
    easyeffects
    eyedropper
    fragments
    gnome-solanum
    insomnia
    mousai
    screenkey
    textpieces
    unstable.obsidian
    unstable-fdd89.gnome-extension-manager
    wireshark
    nitrogen
  ];
}
