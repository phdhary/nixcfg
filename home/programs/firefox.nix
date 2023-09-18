{
  config,
  pkgs,
  ...
}: let
  inherit (pkgs.lib) optionalAttrs isWayland;
  inherit (config.programs) firefox;
  inherit (config.wayland.windowManager) sway;
in {
  # TODO: when i got time migrating this
  programs.firefox = {
    enable = false;
    package = pkgs.latest.firefox-nightly-bin;
  };
  home.sessionVariables =
    optionalAttrs (firefox.enable && isWayland)
    {MOZ_ENABLE_WAYLAND = 1;}
    // optionalAttrs sway.enable {
      XDG_CURRENT_DESKTOP = "sway";
    };
}
