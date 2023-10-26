{ config, namespace, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.programs.git;
in {
  options.${namespace}.programs.git = {
    enable = mkEnableOption "git";
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = "phdhary";
      userEmail = "phdhary@gmail.com";
      extraConfig = {
        init = { defaultBranch = "main"; };
        core = { autocrlf = "input"; };
      };
      aliases = {
        unpushed = "log --oneline --decorate --graph origin/main^..main";
      };
    };

    home.shellAliases = {
      g = "git";
      glo = "git log --oneline --decorate --graph";
      grl = "git reflog";
      gst = "git status";
    };
  };
}
