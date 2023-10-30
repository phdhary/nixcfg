{ config, lib, namespace, ... }:
let
  cfg = config.${namespace}.programs.bash;
  inherit (config.home) homeDirectory;
in {
  options.${namespace}.programs.bash.enable = lib.mkEnableOption "bash";
  config = lib.mkIf cfg.enable {
    programs.bash = {
      enable = true;
      enableCompletion = true;
      profileExtra = ''
        if [ -d "/var/lib/flatpak/exports/bin" ] ; then
          PATH=$PATH:/var/lib/flatpak/exports/bin
        fi
        # added by Nix installer
        if [ -e ${homeDirectory}/.nix-profile/etc/profile.d/nix.sh ]; then
          . ${homeDirectory}/.nix-profile/etc/profile.d/nix.sh;
        fi
      '';
      bashrcExtra = ''
        export SDKMAN_DIR="$HOME/.sdkman"
        [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
      '';
    };
  };
}
