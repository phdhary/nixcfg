{
  config,
  pkgs,
  namespace,
  ...
}: let
  inherit (config.${namespace}) enabled disabled;
in {
  home.packages = with pkgs; [
    alejandra
    amberol
    dbeaver
    dynamic-wallpaper
    eartag
    easyeffects
    eyedropper
    fragments
    gnome-extension-manager
    gnome-solanum
    insomnia
    macchina
    mousai
    nixd
    nixgl.nixGLIntel
    textpieces
    unstable.obsidian
    wormhole-rs
    #
    btop
    exa
    htop
    hyperfine
    fd
    ripgrep
    asciiquarium
    duf
    cmatrix
    sl
    glow
    gitui
    fzf
    gum
    httpie
    lolcat
    ncdu
    trash-cli
    speedtest-cli
    tldr
    tokei
    wireshark
    zellij
    yt-dlp
    screenkey
    lshw
    espeak
  ];

  xdg.systemDirs.data = [
    "${config.home.homeDirectory}/.nix-profile/share" # to make .desktop files detected by DE
  ];

  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "phdhary";
    userEmail = "phdhary@gmail.com";
    extraConfig = {
      init = {defaultBranch = "main";};
      core = {autocrlf = "input";};
    };
    aliases = {
      unpushed = "log --oneline --decorate --graph origin/main^..main";
    };
  };

  ${namespace} = {
    programs = enabled;
    firefox = disabled;
    fonts = enabled;
    kitty = enabled;
    session-things = {
      enable = true;
      enableDnfAliases = true;
    };
    shells = enabled;
    vscode = enabled;
    wezterm = enabled;
    wms-symlink = enabled;
    services.batresudah = enabled;
  };
}
