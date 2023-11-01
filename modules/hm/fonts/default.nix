{ config, lib, namespace, pkgs, packages, ... }:
let cfg = config.${namespace}.fonts;
in {
  options.${namespace}.fonts = { enable = lib.mkEnableOption "fonts"; };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
      [
        fira-code
        ibm-plex
        jetbrains-mono
        source-code-pro
        inter
        # noto-fonts-color-emoji
        (unstable.nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
      ] ++ (with packages.fonts; [ sf-pro-fonts ]);
    fonts.fontconfig.enable = true;
  };
}
