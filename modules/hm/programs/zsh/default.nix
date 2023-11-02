{ config, lib, namespace, pkgs, ... }:
let
  cfg = config.${namespace}.programs.zsh;
  inherit (config.${namespace}.lib) runtimePath;
  inherit (config.lib.file) mkOutOfStoreSymlink;
in {
  options.${namespace}.programs.zsh = { enable = lib.mkEnableOption "zsh"; };
  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      autocd = true;
      dotDir = ".config/zsh";
      history = {
        expireDuplicatesFirst = true;
        extended = true;
        path = "${config.xdg.configHome}/zsh/.zsh_history";
      };
      initExtraBeforeCompInit = ''
        fpath=(~/.config/zsh/completion $fpath)
      '';
      initExtra = builtins.readFile ./zsh-init-extra;
      envExtra = ''
        . "$HOME/.cargo/env"
        . "$HOME/.profile"
        . "$HOME/.config/zsh/.some-function"
      '';
    };
    home.packages = [ pkgs.unstable.zsh-completions ];
    xdg.configFile."zsh/.some-function".source =
      mkOutOfStoreSymlink (runtimePath ./.some-function);
  };
}
