{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  name = "batresudah";
  cfg = config.${namespace}.services.${name};
  script = pkgs.writeShellScriptBin name (builtins.readFile ./batresudah.sh);
in {
  options.${namespace}.services.${name} = {
    enable = mkEnableOption "${name} service";
  };

  config = mkIf cfg.enable {
    systemd.user.services."${name}" = {
      Unit = {Description = "battery notifications";};
      Service = {ExecStart = "${script}/bin/${name}";};
      Install = {WantedBy = ["multi-user.target"];};
    };
  };
}
