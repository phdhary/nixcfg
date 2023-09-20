{
  config,
  pkgs,
  ...
}: let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (config.home.additionalUserInfo) hmConfigPath;
in {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    package = pkgs.unstable.starship;
  };

  home.file.".config/starship.toml".source = mkOutOfStoreSymlink "${hmConfigPath}/home/shells/starship/starship.toml";
}
