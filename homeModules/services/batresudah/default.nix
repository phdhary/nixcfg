{ config, lib, namespace, packages, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  name = "batresudah";
  cfg = config.${namespace}.services.${name};
in {
  options.${namespace}.services.${name} = {
    enable = mkEnableOption "${name} service";
  };

  config = mkIf cfg.enable {
    systemd.user.services."${name}" = {
      Unit = { Description = "a battery notifications through ntfy"; };
      Service = { ExecStart = "${packages.batresudah}/bin/${name}"; };
    };

    systemd.user.timers."${name}" = {
      Unit = { Description = "batresudah.service timer"; };
      Timer = {
        OnBootSec = "0min";
        OnCalendar = "*:5/5"; # start at minute 5, repeat every 5 minute.
        # OnCalendar = "*:*:00"; # every minute
        Unit = "batresudah.service";
      };
      Install = { WantedBy = [ "default.target" ]; };
    };
  };
}
