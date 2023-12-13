{ config, lib, namespace, pkgs, ... }:
let cfg = config.${namespace}.programs.firefox;
in {
  options.${namespace}.programs.firefox = {
    enable = lib.mkEnableOption "Firefox Browser";
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.flake-firefox-nightly.firefox-nightly-bin;
    };
  };

  config = lib.mkIf cfg.enable {
    # TODO: when i got time migrating this
    programs.firefox = {
      enable = true;
      package = cfg.package;
    };
    home.sessionVariables = { MOZ_ENABLE_WAYLAND = 1; };
  };
}
