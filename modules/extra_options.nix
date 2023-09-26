{
  lib,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkOption types;
in {
  options.${namespace} = {
    enabled = mkOption {type = types.attrs;};
    disabled = mkOption {type = types.attrs;};
    additionalUserInfo = {
      hmConfigPath = mkOption {type = types.str;};
    };
  };

  config.${namespace} = {
    enabled = {enable = true;};
    disabled = {enable = false;};
    additionalUserInfo = {
      hmConfigPath = "${config.home.homeDirectory}/.config/home-manager";
    };
  };
}
