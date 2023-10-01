{ config, namespace, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.programs.cli-apps.fzf;
in {
  options.${namespace}.programs.cli-apps.fzf = {
    enable = mkEnableOption "fzf";
  };

  config = mkIf cfg.enable {
    programs.fzf = {
      enable = true;
      defaultCommand = "rg --files";
      defaultOptions = [ "--color=16" ];
      colors = {
        fg = "grey";
        hl = "blue";
        "hl+" = "blue";
      };
    };
  };
}
