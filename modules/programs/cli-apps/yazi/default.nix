{ config, namespace, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (pkgs.lib) mkConfigSymlinkFromList;
  cfg = config.${namespace}.programs.cli-apps.yazi;
in {
  options.${namespace}.programs.cli-apps.yazi = {
    enable = mkEnableOption "yazi";
  };

  config = mkIf cfg.enable {
    home.packages = [
      (let
        inherit (pkgs) writeShellScriptBin symlinkJoin;
        inherit (builtins) readFile;
        yz = writeShellScriptBin "yz" (readFile ./yz.sh);
      in symlinkJoin {
        name = "yazi";
        paths = [ yz pkgs.unstable-fdd89.yazi ];
      })
    ];
    home.file = mkConfigSymlinkFromList {
      relativePath = "modules/programs/cli-apps";
      paths = [ "yazi/keymap.toml" "yazi/yazi.toml" "yazi/theme.toml" ];
    };
  };
}
