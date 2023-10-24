{ config, namespace, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkOption mkIf types;
  inherit (pkgs.lib) mkConfigSymlinkFromList;
  inherit (pkgs) writeShellScriptBin symlinkJoin;
  inherit (builtins) readFile;
  yz = writeShellScriptBin "yz" (readFile ./yz.sh);
  cfg = config.${namespace}.programs.cli-apps.yazi;
  yazi = pkgs.unstable-fdd89.yazi;
  ya = let 
  in symlinkJoin {
    name = "yazi";
    paths = [ yz yazi ];
  };

in {
  options.${namespace}.programs.cli-apps.yazi = {
    enable = mkEnableOption "yazi";
    package = mkOption {
      type = types.package;
      default = ya;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
    home.file = mkConfigSymlinkFromList {
      relativePath = "modules/programs/cli-apps";
      paths = [ "yazi/keymap.toml" "yazi/yazi.toml" "yazi/theme.toml" ];
    };
    xdg.desktopEntries."yazi" = {
      name = "Yazi";
      comment =
        "Blazing fast terminal file manager written in Rust, based on async I/O.";
      icon = "utilities-terminal";
      exec = "${yazi}/bin/yazi";
      categories = [ "ConsoleOnly" "System" "FileTools" "FileManager" ];
      terminal = true;
    };

  };
}
