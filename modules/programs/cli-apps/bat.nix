{ config, namespace, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.programs.cli-apps.bat;
in {
  options.${namespace}.programs.cli-apps.bat = {
    enable = mkEnableOption "bat";
  };

  config = mkIf cfg.enable {
    home.sessionVariables.PAGER = "bat";
    programs.bat = {
      enable = true;
      config = {
        theme = "ansi";
        style = "numbers,changes,header";
      };
    };
  };
}
