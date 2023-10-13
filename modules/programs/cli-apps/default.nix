{ pkgs, packages, ... }: {
  home.packages = with pkgs;
    [
      alejandra
      duf
      espeak
      fd
      git-crypt
      glow
      gum
      htop
      httpie
      hyperfine
      jq
      lolcat
      lshw
      macchina
      ncdu
      nixd
      nixfmt
      nixgl.nixGLIntel
      nixgl.nixVulkanIntel
      hddtemp
      nyancat
      ripgrep
      arandr
      sl
      speedtest-cli
      timer
      tldr
      tokei
      trash-cli
      unstable.yt-dlp
      wormhole-rs
      zellij
    ] ++ (with packages; [ hm-cleanup unimatrix note-taker ]);
}
