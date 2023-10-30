{ lib, config, pkgs, namespace, ... }:
let
  cfg = config.${namespace}.programs.wezterm;
  inherit (config.${namespace}.lib) runtimePath wrapWithNixGLIntel;
  inherit (config.lib.file) mkOutOfStoreSymlink;
in {
  options.${namespace}.programs.wezterm = {
    enable = lib.mkEnableOption "wezterm terminal emulator";
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.unstable.wezterm;
    };
  };

  config = lib.mkIf cfg.enable {
    # home.sessionVariables.TERMINAL = "wezterm";
    programs.wezterm = {
      enable = true;
      package = let
        wezterm = "${cfg.package}/bin/wezterm start --cwd .";
        wrapped_wezterm = wrapWithNixGLIntel "wrapped_wezterm" wezterm;
      in pkgs.symlinkJoin {
        name = "wezterm";
        paths = [ wrapped_wezterm cfg.package ];
      };
      extraConfig = ''return require "config"'';
    };

    xdg.configFile = {
      "wezterm/colors/" = {
        source = mkOutOfStoreSymlink (runtimePath ./colors);
        recursive = true;
      };
      "wezterm/config/" = {
        source = mkOutOfStoreSymlink (runtimePath ./config);
        recursive = true;
      };
    };

    xdg.desktopEntries."org.wezfurlong.wezterm" = {
      name = "WezTerm";
      comment = "Wez's Terminal Emulator";
      icon = "org.wezfurlong.wezterm";
      exec = "wrapped_wezterm %F";
      categories = [ "System" "TerminalEmulator" "Utility" ];
      terminal = false;
    };
  };
}
