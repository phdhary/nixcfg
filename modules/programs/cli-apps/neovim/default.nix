{ config, lib, namespace, pkgs, ... }:
let
  cfg = config.${namespace}.programs.cli-apps.neovim-fhs;
  neovim-fhs-package = pkgs.buildFHSUserEnv {
    name = "nvim";
    targetPkgs = pkgs: (essentials ++ lsps ++ formatter);
    runScript = "/usr/bin/nvim";
  };
  essentials = with pkgs; [
    neovim
    gcc
    zsh
    xclip
    wl-clipboard
    curl
    # nodejs
    # nodePackages.neovim
    # perl
    # unstable.perl538Packages.NeovimExt
  ];
  lsps = with pkgs; [
    ansible-language-server
    efm-langserver
    gopls
    lua-language-server
    marksman
    nil
    nodePackages."@astrojs/language-server"
    nodePackages."@tailwindcss/language-server"
    nodePackages.bash-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.intelephense
    nodePackages.svelte-language-server
    nodePackages.vim-language-server
    nodePackages.vscode-css-languageserver-bin
    nodePackages.vscode-html-languageserver-bin
    nodePackages.vscode-json-languageserver-bin
    nodePackages.vue-language-server
    nodePackages.yaml-language-server
    pyright
    taplo
    texlab
    unstable.emmet-ls
  ];
  formatter = with pkgs; [
    beautysh
    black
    nodePackages.fixjson
    shellharden
    unstable.eslint_d
    unstable.prettierd
    unstable.stylelint
    unstable.stylua
  ];
in {
  options.${namespace}.programs.cli-apps.neovim-fhs = {
    enable = lib.mkEnableOption "neovim-fhs";
    package = lib.mkOption {
      type = lib.types.package;
      default = neovim-fhs-package;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
    # home.file = pkgs.lib.mkConfigSymlinkFromList {
    #   relativePath = "modules/programs/cli-apps";
    #   paths = [ ];
    # };
  };
}
