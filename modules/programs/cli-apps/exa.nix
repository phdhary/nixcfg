{ config, namespace, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.programs.cli-apps.exa;
in {
  options.${namespace}.programs.cli-apps.exa = {
    enable = mkEnableOption "exa";
  };

  config = mkIf cfg.enable {
    programs.exa.enable = true;
    home.shellAliases = { ls = "exa --icons"; };
  };
}
