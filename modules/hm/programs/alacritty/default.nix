{ config, lib, pkgs, namespace, ... }:
let
  cfg = config.${namespace}.programs.alacritty;
  inherit (config.${namespace}.lib) recursiveSymlink wrapWithNixGLIntel;
  inherit (lib) mkEnableOption mkIf mkOption;
  inherit (pkgs.lib) hasSuffix;
  wrapped_alacritty = wrapWithNixGLIntel "wrapped_alacritty" "alacritty";
  joined_alacritty = pkgs.symlinkJoin {
    name = "joined_alacritty";
    paths = [ wrapped_alacritty pkgs.alacritty ];
  };
in {
  options.${namespace}.programs.alacritty = {
    enable = mkEnableOption "alacritty terminal emulator";
    package = mkOption {
      type = lib.types.package;
      default = joined_alacritty;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
    home.sessionVariables.TERMINAL = "wrapped_alacritty";
    xdg.configFile = recursiveSymlink {
      directory = "alacritty";
      path = ./.;
      filter = list:
        builtins.filter (f: (!hasSuffix ".nix" f) && (hasSuffix ".yml" f)) list;
    };
    xdg.desktopEntries."Alacritty" = {
      name = "Alacritty";
      genericName = "Terminal";
      comment = "A fast, cross-platform, OpenGL terminal emulator";
      icon = "Alacritty";
      exec = "wrapped_alacritty %F";
      categories = [ "System" "TerminalEmulator" ];
      terminal = false;
      actions = {
        New = {
          name = "New terminal";
          exec = "wrapped_alacritty";
        };
      };
    };
  };
}
