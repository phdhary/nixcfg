{ config, lib, namespace, packages, ... }:
let
  cfg = config.${namespace}.programs.xob;
  inherit (config.${namespace}.lib) mkXdgConfigLink;
in {
  options.${namespace}.programs.xob.enable = lib.mkEnableOption "xob";
  config = lib.mkIf cfg.enable {
    home.packages = with packages; [ xob_volume xob_brightness xob_server ];
    xdg.configFile = mkXdgConfigLink {
      relativePath = "modules/home-manager/programs";
      directory = "xob";
      paths = [ "styles.cfg" ];
    };
  };
}
