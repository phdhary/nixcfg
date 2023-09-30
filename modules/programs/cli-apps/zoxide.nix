{ config, namespace, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.programs.cli-apps.zoxide;
in {
  options.${namespace}.programs.cli-apps.zoxide = {
    enable = mkEnableOption "zoxide";
  };

  config = mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };
}
