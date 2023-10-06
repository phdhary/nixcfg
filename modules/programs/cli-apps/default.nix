{ pkgs, packages, ... }: {
  home.packages = with pkgs;
    [
      alejandra
      asciiquarium
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
      nyancat
      ripgrep
      sl
      speedtest-cli
      timer
      tldr
      tokei
      trash-cli
      # unstable.nvtop
      # unstable.nvtop-nvidia
      unstable.yt-dlp
      wormhole-rs
      zellij
    ] ++ (with packages; [ hm-cleanup unimatrix note-taker ]);
}
