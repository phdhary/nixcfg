{ pkgs, packages, ... }: {
  home.packages = with pkgs;
    [
      alejandra
      arandr
      caffeine-ng
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
      lolcat
      lshw
      macchina
      ncdu
      nixd
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
      zellij
      # gnome
      adw-gtk3
      gnome-browser-connector
      gnome44Extensions."advanced-alt-tab@G-dH.github.com"
      gnome44Extensions."appindicatorsupport@rgcjonas.gmail.com"
      gnome44Extensions."flypie@schneegans.github.com"
      gnome44Extensions."blur-my-shell@aunetx"
      gnome44Extensions."caffeine@patapon.info"
      gnome44Extensions."forge@jmmaranan.com"
      gnome44Extensions."runcat@kolesnikov.se"
      gnome44Extensions."legacyschemeautoswitcher@joshimukul29.gmail.com"
      gnome44Extensions."mousefollowsfocus@matthes.biz"
      gnome44Extensions."pano@elhan.io"
      gnome44Extensions."space-bar@luchrioh"
      gnome44Extensions."tiling-assistant@leleat-on-github"
      gnome44Extensions."unite@hardpixel.eu"
      gnome44Extensions."just-perfection-desktop@just-perfection"
      gnome44Extensions."arcmenu@arcmenu.com"
      unstable.gnome44Extensions."sane-airplane-mode@kippi"
      unstable.gnome44Extensions."search-light@icedman.github.com"
      # unstable-fdd89.gnome44Extensions."gsconnect@andyholmes.github.io" # doesn't work
    ] ++ (with packages; [ hm-cleanup unimatrix note-taker ]);
  # dconf.settings."org/gnome/shell".enabledExtensions = { };
}
