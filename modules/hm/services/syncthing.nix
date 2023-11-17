{ config, lib, namespace, ... }:
let cfg = config.${namespace}.services.syncthing;
in {
  options.${namespace}.services.syncthing.enable =
    lib.mkEnableOption "syncthing";
  config = lib.mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      tray.enable = true;
    };
  };
}
