{
  config,
  namespace,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  name = "bat";
  cfg = config.${namespace}.programs.cli-apps.${name};
in {
  options.${namespace}.programs.cli-apps.${name} = {
    enable = mkEnableOption "${name}";
  };

  config = mkIf cfg.enable {
    programs.bat = {
      enable = true;
      config = {
        theme = "ansi";
        style = "numbers,changes,header";
      };
    };
  };
}
