{
  config,
  namespace,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.programs.cli-apps.git;
in {
  options.${namespace}.programs.cli-apps.git = {
    enable = mkEnableOption "git";
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
