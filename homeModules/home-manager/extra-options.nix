{ lib, config, namespace, ... }:
let inherit (lib) mkOption types;
in {
  options.${namespace} = {
    enabled = mkOption {
      type = types.attrs;
      default = { enable = true; };
    };
    disabled = mkOption {
      type = types.attrs;
      default = { enable = false; };
    };
    additionalUserInfo = {
      hmConfigPath = mkOption {
        type = types.str;
        default = "${config.home.homeDirectory}/.config/nixcfg";
      };
    };
  };
}
