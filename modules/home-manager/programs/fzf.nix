{ config, namespace, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.programs.fzf;
in {
  options.${namespace}.programs.fzf = {
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
