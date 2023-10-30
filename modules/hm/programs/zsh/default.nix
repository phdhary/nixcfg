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
      initExtra = ''
        zstyle ':completion:*' menu select
        # zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
        zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|=*' 'l:|=* r:|=*'
        # MAPPINGS
        KEYTIMEOUT=1 # 10ms for key sequences
        bindkey '^[[Z' reverse-menu-complete
        bindkey -v # vi mode
        bindkey '^ ' autosuggest-accept
        bindkey '^f' forward-word
        bindkey "^n" down-line-or-search
        bindkey "^p" up-line-or-search
        # bindkey -M vicmd 'V' edit-command-line
        bindkey -s '^z' 'fg^M'
        [[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true
      '';
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
