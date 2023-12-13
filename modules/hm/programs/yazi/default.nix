{ config, namespace, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkOption mkIf types;
  inherit (config.${namespace}.lib) recursiveSymlink;
  cfg = config.${namespace}.programs.yazi;
in {
  options.${namespace}.programs.yazi = {
    enable = mkEnableOption "yazi";
    package = mkOption {
      type = types.package;
      default = pkgs.nixpkgs-23-11.yazi;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
    xdg.configFile = recursiveSymlink {
      directory = "yazi";
      path = ./.;
      filter = list: lib.filter (f: (!lib.hasSuffix ".nix" f)) list;
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
