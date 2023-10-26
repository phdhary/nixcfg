{ config, lib, namespace, pkgs, ... }:
let
  cfg = config.${namespace}.programs.picom;
  inherit (config.${namespace}.lib) mkXdgConfigLink;
  wrapped_picom = pkgs.writeShellScriptBin "wrapped_picom" ''
    if command -v "nixGLIntel" &> /dev/null; then
        nixGLIntel picom "$@"
    else
        picom "$@"
    fi
  '';
  picom_joined = pkgs.symlinkJoin {
    name = "joined_picom";
    paths = [ wrapped_picom pkgs.picom ];
  };
in {
  options.${namespace}.programs.picom = {
    enable = lib.mkEnableOption "picom";
  };
  config = lib.mkIf cfg.enable {
    home.packages = [ picom_joined ];
    xdg.configFile = mkXdgConfigLink {
      relativePath = "modules/hm/programs";
      directory = "picom";
      paths = [ "picom.conf" ];
    };
  };
}
