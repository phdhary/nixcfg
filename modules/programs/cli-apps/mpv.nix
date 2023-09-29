{
  config,
  namespace,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  name = "mpv";
  cfg = config.${namespace}.programs.cli-apps.${name};
in {
  options.${namespace}.programs.cli-apps.${name} = {
    enable = mkEnableOption "${name}";
  };

  config = mkIf cfg.enable {
    programs.mpv = {
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
  };
}
