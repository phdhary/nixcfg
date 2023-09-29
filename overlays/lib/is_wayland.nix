{...}: let
  inherit (builtins) getEnv;
in
  final: prev: {
    lib =
      prev.lib
      // {
        isWayland = getEnv "XDG_SESSION_TYPE" == "wayland";
      };
  }
