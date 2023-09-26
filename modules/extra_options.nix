# this is how to add custom config
{
  lib,
  config,
  namespace,
  ...
}:
with lib; {
  options.${namespace}.additionalUserInfo = {
    hmConfigPath = mkOption {type = types.str;};
  };
  config.${namespace}.additionalUserInfo = {
    hmConfigPath = "${config.home.homeDirectory}/.config/home-manager";
  };
}
