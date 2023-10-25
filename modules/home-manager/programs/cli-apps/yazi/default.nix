{ config, namespace, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkOption mkIf types;
  inherit (config.${namespace}.lib) mkConfigSymlinkFromList;
  cfg = config.${namespace}.programs.cli-apps.yazi;
in {
  options.${namespace}.programs.cli-apps.yazi = {
    enable = mkEnableOption "yazi";
    package = mkOption {
      type = types.package;
      default = pkgs.unstable-fdd89.yazi;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
    home.file = mkConfigSymlinkFromList {
      relativePath = "modules/home-manager/programs/cli-apps";
      paths = [ "yazi/keymap.toml" "yazi/yazi.toml" "yazi/theme.toml" ];
    };
    xdg.desktopEntries."yazi" = {
      name = "Yazi";
      comment =
        "Blazing fast terminal file manager written in Rust, based on async I/O.";
      icon = "utilities-terminal";
      exec = "${cfg.package}/bin/yazi";
      categories = [ "ConsoleOnly" "System" "FileTools" "FileManager" ];
      terminal = true;
    };

  };
}
