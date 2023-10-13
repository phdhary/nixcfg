{ config, namespace, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (pkgs.lib) mkConfigSymlinkFromList;
  cfg = config.${namespace}.programs.cli-apps.yazi;
  package = pkgs.unstable-fdd89.yazi;
in {
  options.${namespace}.programs.cli-apps.yazi = {
    enable = mkEnableOption "yazi";
  };

  config = mkIf cfg.enable {
    home.packages = [
      (let
        inherit (pkgs) writeShellScriptBin symlinkJoin;
        inherit (builtins) readFile;
        yz = writeShellScriptBin "yz" (readFile ./yz.sh);
      in symlinkJoin {
        name = "yazi";
        paths = [ yz package ];
      })
    ];
    home.file = mkConfigSymlinkFromList {
      relativePath = "modules/programs/cli-apps";
      paths = [ "yazi/keymap.toml" "yazi/yazi.toml" "yazi/theme.toml" ];
    };
    xdg.desktopEntries."yazi" = {
      name = "Yazi";
      comment =
        "Blazing fast terminal file manager written in Rust, based on async I/O.";
      icon = "utilities-terminal";
      exec = "${package}/bin/yazi";
      categories = [ "ConsoleOnly" "System" "FileTools" "FileManager" ];
      terminal = true;
    };

  };
}
