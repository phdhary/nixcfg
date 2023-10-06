{ config, namespace, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (pkgs.lib) mkConfigSymlinkFromList;
  cfg = config.${namespace}.programs.cli-apps.lf;
in {
  options.${namespace}.programs.cli-apps.lf = { enable = mkEnableOption "lf"; };

  config = mkIf cfg.enable {
    programs.lf = {
      enable = true;
      settings = {
        hidden = true;
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

    home.file = mkConfigSymlinkFromList {
      relativePath = "modules/programs/cli-apps/";
      paths = [ "lf/my-extra-lfrc" "lf/icons" "lf/colors" ];
    };
  };
}
