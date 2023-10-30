{ config, lib, namespace, ... }:
let cfg = config.${namespace}.session-things;
in {
  options.${namespace}.session-things = {
    enable = lib.mkEnableOption "session things";
    enableDnfAliases = lib.mkEnableOption "dnf alias";
  };

  config = lib.mkIf cfg.enable {
    home.sessionVariables = {
      FREETYPE_PROPERTIES = "cff:no-stem-darkening=0";
      FVM_HOME = "$HOME/development/fvm"; # deprecated
      FVM_CACHE_PATH = "$HOME/development/fvm";
      PNPM_HOME = "${config.xdg.dataHome}/pnpm";
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
      "${config.home.sessionVariables.FVM_CACHE_PATH}/default/bin"
      "${config.home.sessionVariables.PNPM_HOME}"
      "${config.xdg.dataHome}/JetBrains/Toolbox/scripts"
      "${config.xdg.dataHome}/bob/nvim-bin"
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
      l = "ls -la";
      ragner = "ranger";
      ranger = ". ranger";
      rm = "rm -i";
      svim = "sudo -e";
    } // lib.optionalAttrs cfg.enableDnfAliases {
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
