{ config, lib, namespace, pkgs, ... }:
let
  cfg = config.${namespace}.programs.cli-apps.neovim;
  custom-neovim = pkgs.symlinkJoin {
    name = "nvim";
    paths = [ pkgs.neovim ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/nvim \
      --prefix PATH : ${pkgs.lib.makeBinPath (lsps ++ formatter ++ linter)}
    '';
  };
  lsps = with pkgs;
    [
      ansible-language-server
      efm-langserver
      gopls
      lua-language-server
      marksman
      nil
      pyright
      taplo
      texlab
      unstable.emmet-ls
      nodePackages."@astrojs/language-server"
      nodePackages."@tailwindcss/language-server"
    ] ++ (with pkgs.nodePackages; [
      bash-language-server
      dockerfile-language-server-nodejs
      intelephense
      svelte-language-server
      vim-language-server
      vscode-css-languageserver-bin
      vscode-html-languageserver-bin
      vscode-json-languageserver-bin
      vue-language-server
      yaml-language-server
    ]);
  formatter = with pkgs; [
    beautysh
    black
    nodePackages.fixjson
    shellharden
    unstable.prettierd
    unstable.stylua
  ];
  linter = with pkgs; [ unstable.eslint_d unstable.stylelint ];
in {
  options.${namespace}.programs.cli-apps.neovim = {
    enable = lib.mkEnableOption "neovim";
    package = lib.mkOption {
      type = lib.types.package;
      default = custom-neovim;
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