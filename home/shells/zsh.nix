{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    autocd = true;
    initExtra = ''
      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      # mappings
      KEYTIMEOUT=1 # 10ms for key sequences
      bindkey '^[[Z' reverse-menu-complete
      bindkey -v # vi mode
      bindkey '^ ' autosuggest-accept
      bindkey '^f' forward-word
      # bindkey -M vicmd 'V' edit-command-line
      bindkey -s '^z' 'fg^M'
      source "$HOME/.profile"
    '';
    envExtra = ''
      . "$HOME/.cargo/env"
    '';
  };
}
