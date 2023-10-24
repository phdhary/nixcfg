{ lib, config, namespace, ... }:
let
  inherit (lib) mkOption types;
  inherit (builtins) readFile filter isString split length head match getEnv;
in {
  options.${namespace}.lib = {
    enabled = mkOption {
      type = types.attrs;
      default = { enable = true; };
    };
    disabled = mkOption {
      type = types.attrs;
      default = { enable = false; };
    };
    hmConfigPath = mkOption {
      type = types.str;
      default = "${config.home.homeDirectory}/.config/nixcfg";
    };
    isWayland = mkOption {
      type = types.anything;
      default = getEnv "XDG_SESSION_TYPE" == "wayland";
    };
    isOS = mkOption {
      type = types.anything;
      default = name:
        let
          os_release = readFile "/etc/os-release";
          os_lines = filter isString (split "\n" os_release);
          safeHead = xs: if length xs == 0 then null else head xs;
          get_os_field = key:
            safeHead (head (filter (x: x != null) (map (match key) os_lines)));
          osId = get_os_field "ID=(.+)";
        in osId == name;
    };
  };
}
