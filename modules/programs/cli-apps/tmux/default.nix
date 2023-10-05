{ config, lib, namespace, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (pkgs.lib) mkConfigSymlinkFromList;
  cfg = config.${namespace}.programs.cli-apps.tmux;
in {
  options.${namespace}.programs.cli-apps.tmux = {
    enable = mkEnableOption "tmux";
  };

  config = mkIf cfg.enable {
    home.file = mkConfigSymlinkFromList {
      relativePath = "modules/programs/cli-apps";
      paths = [ "tmux/my-config.conf" ];
    };

    programs.tmux = {
      enable = true;
      mouse = true;
      clock24 = true;
      newSession = true;
      baseIndex = 1;
      escapeTime = 0;
      # keyMode = "vi";
      prefix = "C-a";
      terminal = "tmux-256color";
      historyLimit = 50000;
      customPaneNavigationAndResize = true;
      extraConfig = ''
        bind -n M-g display-popup -w 100% -E ${./t}
        source-file ${config.home.homeDirectory}/.config/tmux/my-config.conf
      '';
      plugins = with pkgs.tmuxPlugins; [
        {
          plugin = resurrect;
          extraConfig = "set -g @resurrect-capture-pane-contents 'on'";
        }
        {
          plugin = continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
            # set -g @continuum-save-interval '60' # minutes
          '';
        }
        {
          plugin = tilish;
          extraConfig = ''
            set -g @tilish-navigator 'on' # enable tilish with vim-tmux-navigator mappings
            set -g @tilish-dmenu 'on'
          '';
        }
      ];
    };

    home.shellAliases = {
      ta = "tmux attach -t";
      tad = "tmux attach -d -t";
      ts = "tmux new-session -s";
      tl = "tmux list-sessions";
      tksv = "tmux kill-server";
      tkss = "tmux kill-session -t";
    };
  };
}
