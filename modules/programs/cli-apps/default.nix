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
      # nvtop
      # nvtop-nvidia
      nyancat
      ripgrep
      sl
      speedtest-cli
      timer
      tldr
      tokei
      trash-cli
      unstable.yt-dlp
      wormhole-rs
      zellij
    ] ++ [ packages.hm-cleanup ];
}
