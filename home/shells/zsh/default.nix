{
  config,
  pkgs,
  ...
}: let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (config.home.additionalUserInfo) hmConfigPath;
in {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    autocd = true;
    initExtra = ''
      zstyle ':completion:*' menu select
      # zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|=*' 'l:|=* r:|=*'
      # mappings
      KEYTIMEOUT=1 # 10ms for key sequences
      bindkey '^[[Z' reverse-menu-complete
      bindkey -v # vi mode
      bindkey '^ ' autosuggest-accept
      bindkey '^f' forward-word
      # bindkey -M vicmd 'V' edit-command-line
      bindkey -s '^z' 'fg^M'
      source "$HOME/.profile"
      source "$HOME/.some-function"
    '';
    envExtra = ''
      . "$HOME/.cargo/env"
    '';
  };
  home.packages = with pkgs.unstable; [zsh-completions];
  home.file.".some-function".source = mkOutOfStoreSymlink "${hmConfigPath}/home/shells/zsh/.some-function";
}
