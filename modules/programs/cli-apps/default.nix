{ pkgs, packages, ... }: {
  home.packages = with pkgs;
    [
      alejandra
      asciiquarium
      cmatrix
      duf
      espeak
      fd
      git-crypt
      glow
      gum
      htop
      httpie
      hyperfine
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
    ] ++ [ packages.hm-cleanup ];
}
