{ config, lib, pkgs, namespace, ... }:
let
  inherit (lib) mkEnableOption mkIf mkOption;
  inherit (pkgs.lib) mkConfigSymlinkFromList;
  cfg = config.${namespace}.programs.gui-apps.alacritty;
  wrapped_alacritty = pkgs.writeShellScriptBin "wrapped_alacritty" ''
    if command -v "nixGLIntel" &> /dev/null; then
        nixGLIntel alacritty "$@"
    else
        alacritty "$@"
    fi
  '';
  joined = pkgs.symlinkJoin {
    name = "joined_alacritty";
    paths = [ wrapped_alacritty pkgs.alacritty ];
  };
in {
  options.${namespace}.programs.gui-apps.alacritty = {
    enable = mkEnableOption "alacritty terminal emulator";
    package = mkOption {
      type = lib.types.package;
      default = joined;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
    home.sessionVariables.TERMINAL = "wrapped_alacritty";
    home.file = mkConfigSymlinkFromList {
      relativePath = "modules/home-manager/programs/gui-apps/alacritty";
      paths = [
        "alacritty/alacritty.yml"
        "alacritty/current_theme.yml"
        "alacritty/themes/"
      ];
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
