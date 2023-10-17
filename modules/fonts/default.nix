{ config, lib, namespace, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.fonts;
in {
  options.${namespace}.fonts = {
    enable = mkEnableOption "fonts";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      fira-code
      ibm-plex
      jetbrains-mono
      source-code-pro
      inter
      # noto-fonts-color-emoji
      (unstable.nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    ];
    fonts.fontconfig.enable = true;
  };
}
