{ config, namespace, ... }:
let inherit (config.${namespace}.lib) enabled disabled;
in {
  xdg.systemDirs.data = [
    "${config.home.homeDirectory}/.nix-profile/share" # to make .desktop files detected by DE
  ];

  programs.home-manager.enable = true;
  home.shellAliases.hm =
    "home-manager --flake ${config.${namespace}.lib.hmConfigPath}#laken-dev";

  ${namespace} = {
    fonts = enabled;
    programs = {
      cli-apps = {
        bat = enabled;
        btop = enabled;
        eza = enabled;
        fzf = enabled;
        git = enabled;
        # lf = enabled;
        mpv = enabled;
        ncmpcpp = enabled;
        neovim = enabled;
        readline = enabled;
        tmux = enabled;
        yazi = enabled;
        zoxide = enabled;
      };
      gui-apps = {
        alacritty = enabled;
        firefox = disabled;
        vscode = enabled;
        # wezterm = enabled;
        rofi = enabled;
      };
    };
    services = { batresudah = enabled; };
    session-things = {
      enable = true;
      enableDnfAliases = true;
    };
    shells = enabled;
    wm-things = enabled;
  };
}
