{ config, lib, namespace, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (pkgs.lib) optionalAttrs;
  inherit (config.wayland.windowManager) sway;
  cfg = config.${namespace}.programs.firefox;
in {
  options.${namespace}.programs.firefox = {
    enable = mkEnableOption "Firefox Browser";
  };

  config = mkIf cfg.enable {
    # TODO: when i got time migrating this
    programs.firefox = {
      enable = true;
      package = pkgs.latest.firefox-nightly-bin;
    };
    home.sessionVariables = {
      MOZ_ENABLE_WAYLAND = 1;
    } // optionalAttrs sway.enable { XDG_CURRENT_DESKTOP = "sway"; };
  };
}
