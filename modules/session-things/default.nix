{ pkgs, config, lib, namespace, ... }:
let
  inherit (lib) mkEnableOption mkIf mkMerge;
  inherit (pkgs.lib) optionalAttrs isWayland;
  cfg = config.${namespace}.session-things;
in {
  options.${namespace}.session-things = {
    enable = mkEnableOption "session things";
    enableDnfAliases = mkEnableOption "dnf alias";
  };

  config = mkIf cfg.enable {
    home.sessionVariables = mkMerge [{
      EDITOR = "nvim";
      FREETYPE_PROPERTIES = "cff:no-stem-darkening=0";
      FVM_HOME = "$HOME/development/fvm";
      MANPAGER = "nvim -c Man!";
      PNPM_HOME = "${config.xdg.dataHome}/pnpm";
      SYSTEMD_EDITOR = "nvim";
      NIXOS_OZONE_WL = "1";
    }
    # (optionalAttrs isWayland {NIXOS_OZONE_WL = "1";})
      ];

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

    home.shellAliases = {
      "build_runner:build" =
        "flutter pub run build_runner build --delete-conflicting-outputs";
      "build_runner:watch" =
        "flutter pub run build_runner watch --delete-conflicting-outputs";
      ":q" = "exit";
      _ = ''sudo -s PATH="$PATH" exec "$@"'';
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      "......" = "cd ../../../../..";
      dlmp3pl = ''
        yt-dlp -f bestaudio -x --audio-format mp3 --audio-quality 320k --embed-thumbnail --add-metadata --postprocessor-args "-id3v2_version 3"'';
      hm = "home-manager";
      l = "ls -la";
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
    } // optionalAttrs cfg.enableDnfAliases {
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
  };
}
