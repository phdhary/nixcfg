{ config, namespace, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.programs.readline;
in {
  options.${namespace}.programs.readline = {
    enable = mkEnableOption "readline";
  };

  config = mkIf cfg.enable {
    programs.readline = {
      enable = true;
      variables = {
        editing-mode = "vi";
        keymap = "vi";
      };
    };
  };
}
