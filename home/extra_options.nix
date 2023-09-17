{
  lib,
  config,
  ...
}:
with lib; {
  options.home.additionalUserInfo = {
    hmConfigPath = mkOption {type = types.str;};
  };
  config.home.additionalUserInfo = {
    hmConfigPath = "${config.home.homeDirectory}/.config/home-manager";
  };
}
