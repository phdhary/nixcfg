{ config, namespace, ... }:
let inherit (config.${namespace}) enabled disabled;
in {
  xdg.systemDirs.data = [
    "${config.home.homeDirectory}/.nix-profile/share" # to make .desktop files detected by DE
  ];

  programs.home-manager.enable = true;

  ${namespace} = {
    fonts = enabled;
    programs = {
      cli-apps = {
        bat = enabled;
        btop = enabled;
        eza = enabled;
        fzf = enabled;
        git = enabled;
        lf = enabled;
        mpv = enabled;
        ncmpcpp = enabled;
        readline = enabled;
        tmux = enabled;
        yazi = enabled;
        zoxide = enabled;
      };
      gui-apps = {
        firefox = disabled;
        kitty = enabled;
        vscode = enabled;
        wezterm = enabled;
      };
    };
    services = { batresudah = enabled; };
    session-things = {
      enable = true;
      enableDnfAliases = true;
    };
    shells = enabled;
    wms-symlink = enabled;
    hyprland = enabled;
    bspwm = enabled;
  };
}
