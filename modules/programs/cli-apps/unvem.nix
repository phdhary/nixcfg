# soon neovim :)
{ config, namespace, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.programs.cli-apps.unvem;
in {
  options.${namespace}.programs.cli-apps.unvem = {
    enable = mkEnableOption "unvem";
  };

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
    };
  };
}
