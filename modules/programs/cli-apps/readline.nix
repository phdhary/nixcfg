{
  config,
  namespace,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  name = "readline";
  cfg = config.${namespace}.programs.cli-apps.${name};
in {
  options.${namespace}.programs.cli-apps.${name} = {
    enable = mkEnableOption "${name}";
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
