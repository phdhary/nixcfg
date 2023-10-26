{ config, namespace, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.${namespace}.lib) mkConfigSymlinkFromList;
  cfg = config.${namespace}.programs.lf;
in {
  options.${namespace}.programs.lf = { enable = mkEnableOption "lf"; };

  config = mkIf cfg.enable {
    programs.lf = {
      enable = true;
      package = pkgs.unstable-fdd89.lf;
      settings = {
        ignorecase = true;
        smartcase = true;
        incsearch = true;
        dirfirst = true;
        wrapscan = true;
        scrolloff = 5;
        tabstop = 4;
      };
      keybindings = {
        m = "";
        o = "";
        d = "";
      };
      extraConfig = ''
        source ${config.home.homeDirectory}/.config/lf/my-extra-lfrc
      '';
    };
    home.packages = [ pkgs.chafa ];

    home.file = mkConfigSymlinkFromList {
      relativePath = "modules/home-manager/programs";
      paths = [
        "lf/icons"
        "lf/colors"
        "lf/my-extra-lfrc"
        "lf/lf_kitty_clean"
        "lf/lf_kitty_preview"
        "lf/lf_sixel_preview"
      ];
    };
  };
}
