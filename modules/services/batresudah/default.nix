{
  config,
  lib,
  namespace,
  packages,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  name = "batresudah";
  cfg = config.${namespace}.services.${name};
in {
  options.${namespace}.services.${name} = {
    enable = mkEnableOption "${name} service";
  };

  config = mkIf cfg.enable {
    systemd.user.services."${name}" = {
      Unit = {Description = "battery notifications";};
      Service = {ExecStart = "${packages.batresudah}/bin/${name}";};
      Install = {WantedBy = ["default.target"];};
    };
  };
}
