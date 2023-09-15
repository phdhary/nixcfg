{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      _ = "sudo";
    };
    profileExtra = ''
      if [ -d "/var/lib/flatpak/exports/bin" ] ; then
        PATH=$PATH:/var/lib/flatpak/exports/bin
      fi
      # FZF
      if type rg &> /dev/null; then
          export FZF_DEFAULT_COMMAND='rg --files'
          export FZF_DEFAULT_OPTS="
          --color=16
          --color=fg:grey,hl:blue
          --color=hl+:blue"
          # export FZF_DEFAULT_OPTS=" \
          # --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
      fi

      source "$HOME/.some-function"
    '';
    bashrcExtra = ''
      export SDKMAN_DIR="$HOME/.sdkman"
      [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
    '';
    # if [ -e /home/laken/.nix-profile/etc/profile.d/nix.sh ]; then . /home/laken/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
  };

  # home.file.".inputrc".source = ./.inputrc;

  programs.readline = {
    enable = true;
    variables = {
      editing-mode = "vi";
      keymap = "vi";
    };
  };
}
