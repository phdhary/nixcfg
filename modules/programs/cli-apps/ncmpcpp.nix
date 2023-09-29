{
  config,
  namespace,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  name = "ncmpcpp";
  cfg = config.${namespace}.programs.cli-apps.${name};
in {
  options.${namespace}.programs.cli-apps.${name} = {
    enable = mkEnableOption "${name}";
  };

  config = mkIf cfg.enable {
    programs.ncmpcpp = {
      enable = true;
    };
    xdg.desktopEntries."my.dude.ncmpcpp" = {
      name = "ncmpcpp";
      comment = "ncmpcpp cli app";
      icon = "io.bassi.Amberol";
      exec = "launch-ncmpcpp";
      categories = ["AudioVideo" "Music" "Audio" "ConsoleOnly"];
      terminal = true;
    };
  };
}
