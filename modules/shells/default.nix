{ config, lib, namespace, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf mkMerge;
  inherit (pkgs.lib) mkSymlinkFromList mkConfigSymlinkFromList;
  inherit (config.home) homeDirectory;
  cfg = config.${namespace}.shells;
in {
  options.${namespace}.shells = { enable = mkEnableOption "shells"; };

  config = mkIf cfg.enable {
    programs.bash = {
      enable = true;
      enableCompletion = true;
      profileExtra = ''
        if [ -d "/var/lib/flatpak/exports/bin" ] ; then
          PATH=$PATH:/var/lib/flatpak/exports/bin
        fi
        # added by Nix installer
        if [ -e ${homeDirectory}/.nix-profile/etc/profile.d/nix.sh ]; then
          . ${homeDirectory}/.nix-profile/etc/profile.d/nix.sh;
        fi
      '';
      bashrcExtra = ''
        export SDKMAN_DIR="$HOME/.sdkman"
        [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
      '';
    };

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
        # MAPPINGS
        KEYTIMEOUT=1 # 10ms for key sequences
        bindkey '^[[Z' reverse-menu-complete
        bindkey -v # vi mode
        bindkey '^ ' autosuggest-accept
        bindkey '^f' forward-word
        # bindkey -M vicmd 'V' edit-command-line
        bindkey -s '^z' 'fg^M'
      '';
      envExtra = ''
        . "$HOME/.cargo/env"
        . "$HOME/.profile"
        . "$HOME/.some-function"
      '';
      initExtraBeforeCompInit = ''
        fpath=(~/.zsh/completion $fpath)
      '';
    };

    home.packages = with pkgs.unstable; [ zsh-completions ];

    home.file = let relativePath = "/modules/shells/";
    in mkMerge [
      (mkSymlinkFromList {
        inherit relativePath;
        paths = [ ".some-function" ];
      })
      (mkConfigSymlinkFromList {
        inherit relativePath;
        paths = [ "starship.toml" ];
      })
    ];

    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      package = pkgs.unstable.starship;
    };
  };
}
