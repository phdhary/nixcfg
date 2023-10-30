{ config, namespace, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.${namespace}.lib) runtimePath recursiveSymlink;
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
        source ${runtimePath ./my-extra-lfrc}/.config/lf/my-extra-lfrc
      '';
    };
    home.packages = [ pkgs.chafa ];
    xdg.configFile = recursiveSymlink {
      directory = "lf";
      path = ./.;
      filter = list: lib.filter (f: !lib.hasSuffix ".nix" f) list;
    };
  };
}
