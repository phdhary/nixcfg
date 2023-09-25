{pkgs, ...}: {
  home.packages = with pkgs; [
    fira-code
    ibm-plex
    jetbrains-mono
    source-code-pro
    (unstable.nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
  ];
  fonts.fontconfig.enable = true;
}
