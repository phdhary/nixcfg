{ config, lib, namespace, packages, ... }:
let
  cfg = config.${namespace}.programs.xob;
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (config.${namespace}.lib) runtimePath;
in {
  options.${namespace}.programs.xob.enable = lib.mkEnableOption "xob";
  config = lib.mkIf cfg.enable {
    home.packages = with packages; [ xob_volume xob_brightness xob_server ];
    xdg.configFile."xob/styles.cfg".source =
      mkOutOfStoreSymlink (runtimePath ./styles.cfg);
  };
}
