{ config, namespace, ... }:
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
      enable-basic-cli = true;
      enable-basic-gui = true;
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
    services = { batresudah = enabled; };
    session-things = {
      enable = true;
      enableDnfAliases = true;
    };
    wm.bspwm = enabled;
  };
}
