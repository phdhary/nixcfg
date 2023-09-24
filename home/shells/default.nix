{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./bash.nix
    ./readline.nix
    ./starship
    ./zsh
  ];

  home.sessionVariables = let
    inherit (pkgs.lib) optionalAttrs isWayland;
  in
    {
      EDITOR = "nvim";
      FREETYPE_PROPERTIES = "cff:no-stem-darkening=0";
      FVM_HOME = "$HOME/development/fvm";
      MANPAGER = "nvim -c Man!";
      NEOVIDE_FRAMELESS = "true";
      NEOVIDE_MULTIGRID = "true";
      PAGER = "bat";
      PNPM_HOME = "${config.xdg.dataHome}/pnpm";
      SYSTEMD_EDITOR = "nvim";
      TERMINAL = "wezterm";
    }
    // optionalAttrs isWayland
    {
      NIXOS_OZONE_WL = "1";
    };

  home.sessionPath = [
    "$HOME/.cargo/bin"
    "$HOME/.local/bin"
    "$HOME/.pub-cache/bin"
    "$HOME/Android/Sdk/platform-tools"
    "$HOME/development/flutter"
    "$HOME/go/bin"
    "${config.home.sessionVariables.FVM_HOME}/default/bin"
    "${config.home.sessionVariables.PNPM_HOME}"
    "${config.xdg.dataHome}/JetBrains/Toolbox/scripts"
    "${config.xdg.dataHome}/bob/nvim-bin"
    "${config.xdg.dataHome}/nvim/mason/bin"
  ];

  home.shellAliases =
    {
      "build_runner:build" = "flutter pub run build_runner build --delete-conflicting-outputs";
      "build_runner:watch" = "flutter pub run build_runner watch --delete-conflicting-outputs";
      _ = "sudo";
      dlmp3pl = ''yt-dlp -f bestaudio -x --audio-format mp3 --audio-quality 320k --embed-thumbnail --add-metadata --postprocessor-args "-id3v2_version 3"'';
      g = "git";
      glo = "git log --oneline --decorate --graph";
      grl = "git reflog";
      gst = "git status";
      hm = "home-manager";
      l = "ls -la";
      lg = "lazygit";
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
    }
    // {
      # dnf
      dnfl = "dnf list";
      dnfli = "dnf list installed";
      dnfgl = "dnf grouplist";
      dnfmc = "dnf makecache";
      dnfp = "dnf info";
      dnfs = "dnf search";
      dnfu = "sudo dnf upgrade";
      dnfi = "sudo dnf install";
      dnfgi = "sudo dnf groupinstall";
      dnfr = "sudo dnf remove";
      dnfgr = "sudo dnf groupremove";
      dnfc = "sudo dnf clean all";
    };
}
