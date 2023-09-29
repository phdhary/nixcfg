{
  config,
  namespace,
  lib,
  pkgs,
  packages,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.programs;
in {
  options.${namespace}.programs = {
    enable = mkEnableOption "programs";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs;
      [
        alejandra
        amberol
        asciiquarium
        cmatrix
        dbeaver
        duf
        dynamic-wallpaper
        eartag
        easyeffects
        espeak
        exa
        eyedropper
        fd
        fragments
        glow
        gnome-extension-manager
        gnome-solanum
        gum
        htop
        httpie
        hyperfine
        insomnia
        lolcat
        lshw
        macchina
        mousai
        ncdu
        nixd
        nixgl.nixGLIntel
        ripgrep
        screenkey
        sl
        speedtest-cli
        textpieces
        tldr
        tokei
        trash-cli
        unstable.obsidian
        wireshark
        wormhole-rs
        yt-dlp
        zellij
      ]
      ++ [packages.hm-cleanup];
  };
}
