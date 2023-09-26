{...}: let
  inherit (builtins) getEnv;
in {
  name = "isWayland";
  value = getEnv "XDG_SESSION_TYPE" == "wayland";
}
