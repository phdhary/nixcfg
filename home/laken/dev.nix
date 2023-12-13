{ config, namespace, pkgs, packages, ... }:
let inherit (config.${namespace}.lib) enabled disabled runtimePath;
in {
  xdg.systemDirs.data = [
    "${config.home.homeDirectory}/.nix-profile/share" # to make .desktop files detected by DE
  ];

  programs.home-manager.enable = true;
  home.shellAliases.hm =
    "home-manager --flake ${runtimePath ../../.}#laken-dev";

  ${namespace} = {
    fonts = enabled;
    programs = {
      alacritty = enabled;
      bat = enabled;
      btop = enabled;
      eza = enabled;
      firefox = disabled;
      fzf = enabled;
      git = enabled;
      gnome-packs = enabled;
      mpv = enabled;
      ncmpcpp = enabled;
      neovim = enabled;
      pop-shell = enabled;
      readline = enabled;
      rofi = enabled;
      tmux = enabled;
      vscode = enabled;
      yazi = enabled;
      zoxide = enabled;
      zathura = enabled;
      # shell
      bash = enabled;
      zsh = enabled;
      starship = enabled;
    };
    services = {
      batresudah = enabled;
      syncthing = enabled;
    };
    session-things = {
      enable = true;
      enableDnfAliases = true;
    };
    wm = {
      bspwm = enabled;
      dwm = enabled;
    };
  };

  home.packages = let
    cli = with pkgs;
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
        imv
        jq
        jqp
        yq
        lolcat
        lshw
        macchina
        # fastfetch
        ncdu
        nixfmt
        nixgl.nixGLIntel
        nixgl.nixVulkanIntel
        nyancat
        powertop
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
      ] ++ (with packages; [ dmenu hm-cleanup unimatrix note-taker dyetide ]);
    gui = with pkgs; [
      amberol
      # bottles
      cpu-x
      dbeaver
      dynamic-wallpaper
      eartag
      easyeffects
      eyedropper
      fragments
      insomnia
      mousai
      screenkey
      textpieces
      unstable.obsidian
      unstable.gnome-extension-manager
      wireshark
      nitrogen
    ];
  in cli ++ gui;
}
