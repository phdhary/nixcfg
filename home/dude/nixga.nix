{ config, namespace, ... }:
let inherit (config.${namespace}.lib) enabled disabled;
in {
  xdg.systemDirs.data = [
    "${config.home.homeDirectory}/.nix-profile/share" # to make .desktop files detected by DE
  ];

  programs.home-manager.enable = true;
  home.shellAliases.hm =
    "home-manager --flake ${config.${namespace}.lib.hmConfigPath}#dude-nixga";

  ${namespace} = {
    fonts = enabled;
    programs = {
      alacritty = enabled;
      bat = enabled;
      btop = enabled;
      eza = enabled;
      # firefox = disabled;
      fzf = enabled;
      git = enabled;
      # mpv = enabled;
      ncmpcpp = enabled;
      neovim = enabled;
      readline = enabled;
      rofi = enabled;
      tmux = enabled;
      yazi = enabled;
      zoxide = enabled;
    };
    # services = { batresudah = enabled; };
    session-things = {
      enable = true;
      enableDnfAliases = true;
    };
    shells = enabled;
    # wm.bspwm = enabled;
  };
}
