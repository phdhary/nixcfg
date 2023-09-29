{
  config,
  namespace,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  name = "fzf";
  cfg = config.${namespace}.programs.cli-apps.${name};
in {
  options.${namespace}.programs.cli-apps.${name} = {
    enable = mkEnableOption "${name}";
  };

  config = mkIf cfg.enable {
    programs.fzf = {
      enable = true;
      defaultCommand = "rg --files";
      defaultOptions = ["--color=16"];
      colors = {
        fg = "grey";
        hl = "blue";
        "hl+" = "blue";
      };
    };
  };
}
