{
  config,
  namespace,
  ...
}: let
  inherit (config.${namespace}) enabled disabled;
in {
  xdg.systemDirs.data = [
    "${config.home.homeDirectory}/.nix-profile/share" # to make .desktop files detected by DE
  ];

  programs.home-manager.enable = true;

  ${namespace} = {
    programs = {
      enable = true;
      cli-apps = {
        bat = enabled;
        btop = enabled;
        fzf = enabled;
        git = enabled;
        mpv = enabled;
        ncmpcpp = enabled;
        readline = enabled;
        zoxide = enabled;
      };
    };
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
