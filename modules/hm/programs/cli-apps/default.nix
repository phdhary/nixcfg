{ config, pkgs, lib, packages, namespace, ... }:
let
  cfg = config.${namespace}.programs;
  inherit (lib) mkEnableOption mkIf;
in {
  options.${namespace}.programs = {
    enable-basic-cli = mkEnableOption "basic";
  };
  config = mkIf cfg.enable-basic-cli {
    home.packages = with pkgs;
      [
        arandr
        caffeine-ng
        cava
        duf
        espeak
        fd
        git-crypt
        glow
        gum
        hddtemp
        htop
        httpie
        hyperfine
        jq
        jqp
        yq
        lolcat
        lshw
        macchina
        ncdu
        nixfmt
        nixgl.nixGLIntel
        nixgl.nixVulkanIntel
        nyancat
        ripgrep
        sl
        speedtest-cli
        timer
        tldr
        tokei
        trash-cli
        ueberzugpp
        unstable.yt-dlp
        wormhole-rs
        xdotool
        zellij
      ] ++ (with packages; [ dmenu hm-cleanup unimatrix note-taker ]);
  };
}
