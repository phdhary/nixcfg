{config, ...}: {
  imports = [
    ./bash.nix
    ./zsh.nix
    ./starship.nix
  ];

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  home.sessionVariables = {
    EDITOR = "${config.xdg.dataHome}/bob/nvim-bin";
    FREETYPE_PROPERTIES = "cff:no-stem-darkening=0";
    FVM_HOME = "$HOME/development/fvm";
    MANPAGER = "nvim -c Man!";
    NEOVIDE_FRAMELESS = "true";
    NEOVIDE_MULTIGRID = "true";
    PAGER = "bat";
    PNPM_HOME = "${config.xdg.dataHome}/pnpm";
    SYSTEMD_EDITOR = "nvim";
    TERMINAL = "kitty";
  };

  home.sessionPath = [
    "$HOME/.cargo/bin"
    "$HOME/.local/bin"
    "$HOME/.pub-cache/bin"
    "$HOME/Android/Sdk/platform-tools"
    "$HOME/development/flutter"
    "$HOME/development/fvm/default/bin"
    "$HOME/go/bin"
    "${config.home.sessionVariables.EDITOR}"
    "${config.home.sessionVariables.PNPM_HOME}"
    "${config.xdg.dataHome}/JetBrains/Toolbox/scripts"
    "${config.xdg.dataHome}/nvim/mason/bin"
  ];

  home.shellAliases = {
    "build_runner:build" = "flutter pub run build_runner build --delete-conflicting-outputs";
    "build_runner:watch" = "flutter pub run build_runner watch --delete-conflicting-outputs";
    dlmp3pl = ''yt-dlp -f bestaudio -x --audio-format mp3 --audio-quality 320k --embed-thumbnail --add-metadata --postprocessor-args "-id3v2_version 3"'';
    g = "git";
    glo = "git log --oneline --decorate --graph";
    grl = "git reflog";
    gst = "git status";
    lg = "lazygit";
    l = "ls -la";
    ls = "exa --icons";
    lzd = "lazydocker";
    nimv = "nvim";
    nivm = "nvim";
    nmiv = "nvim";
    nmvi = "nvim";
    nvmi = "nvim";
    ragner = "ranger";
    ranger = ". ranger";
    rm = "rm -i";
    svim = "sudo -e";
  };
}
