{ config, lib, namespace, pkgs, ... }:
let
  cfg = config.${namespace}.programs.neovim;
  inherit (config.${namespace}.lib) runtimePath;
  inherit (config.lib.file) mkOutOfStoreSymlink;

  custom-neovim = pkgs.symlinkJoin {
    name = "nvim";
    paths = [ pkgs.neovim ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/nvim \
      --prefix PATH : ${pkgs.lib.makeBinPath (lsp ++ formatter ++ linter)}
    '';
  };
  lsp = with pkgs;
    [
      zig # not lsp
      ansible-language-server
      ccls
      efm-langserver
      gopls
      lua-language-server
      marksman
      nil
      nixd
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
    alejandra
    beautysh
    black
    nodePackages.fixjson
    shellharden
    unstable.prettierd
    unstable.stylua
    yq
  ];
  linter = with pkgs; [ unstable.eslint_d unstable.stylelint ];
in {
  options.${namespace}.programs.neovim = {
    enable = lib.mkEnableOption "neovim";
    package = lib.mkOption {
      type = lib.types.package;
      default = custom-neovim;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
    home.sessionVariables = {
      MANPAGER = "nvim -c Man!";
      EDITOR = "nvim";
      SYSTEMD_EDITOR = "nvim";
    };
    home.shellAliases = {
      nimv = "nvim";
      nivm = "nvim";
      nmiv = "nvim";
      nmvi = "nvim";
      nvmi = "nvim";
    };
    home.sessionPath = [ "${config.xdg.dataHome}/bob/nvim-bin" ]; # fallback
    xdg.configFile."nvim/" = {
      recursive = true;
      source = mkOutOfStoreSymlink (runtimePath ./nvim);
    };
  };
}
