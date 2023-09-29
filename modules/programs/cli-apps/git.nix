{
  config,
  namespace,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  name = "git";
  cfg = config.${namespace}.programs.cli-apps.${name};
in {
  options.${namespace}.programs.cli-apps.${name} = {
    enable = mkEnableOption "${name}";
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = "phdhary";
      userEmail = "phdhary@gmail.com";
      extraConfig = {
        init = {defaultBranch = "main";};
        core = {autocrlf = "input";};
      };
      aliases = {
        unpushed = "log --oneline --decorate --graph origin/main^..main";
      };
    };
  };
}
