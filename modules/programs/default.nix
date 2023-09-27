{
  config,
  namespace,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.programs;
in {
  options.${namespace}.programs = {
    enable = mkEnableOption "programs";
  };

  config = mkIf cfg.enable {
    programs = {
      bat = {
        enable = true;
        config = {
          theme = "ansi";
          style = "numbers,changes,header";
        };
      };
      mpv = {
        enable = true;
        config = {
          # sub-font = "SF Pro Display";
          sub-font = "Arial Regular";
          sub-border-size = 1;
          sub-color = "#CDCDCD";
          sub-shadow = 3;
          sub-shadow-color = "#33000000";
          sub-shadow-offset = 2;
          save-position-on-quit = "yes";
        };
      };
      readline = {
        enable = true;
        variables = {
          editing-mode = "vi";
          keymap = "vi";
        };
      };
      zoxide = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
      };
    };

    xdg.desktopEntries."my.dude.ncmpcpp" = {
      name = "ncmpcpp";
      comment = "ncmpcpp cli app";
      icon = "io.bassi.Amberol";
      exec = "launch-ncmpcpp";
      categories = ["AudioVideo" "Music" "Audio" "ConsoleOnly"];
      terminal = true;
    };
  };
}
