{ config, lib, namespace, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (pkgs.lib) mkConfigSymlinkFromList;
  cfg = config.${namespace}.programs.cli-apps.tmux;
  tmux-conf = "my-tmux.conf";
  tmate-conf = "my-tmate.conf";
in {
  options.${namespace}.programs.cli-apps.tmux = {
    enable = mkEnableOption "tmux";
  };

  config = mkIf cfg.enable {
    home = {
      file = mkConfigSymlinkFromList {
        relativePath = "modules/programs/cli-apps";
        paths = [ "tmux/${tmux-conf}" "tmux/${tmate-conf}" ];
      };
      shellAliases = {
        ta = "tmux attach -t";
        tad = "tmux attach -d -t";
        ts = "tmux new-session -s";
        tl = "tmux list-sessions";
        tksv = "tmux kill-server";
        tkss = "tmux kill-session -t";
      };
    };

    programs.tmate = {
      enable = true;
      extraConfig = ''
        source-file ${config.home.homeDirectory}/.config/tmux/${tmate-conf}
      '';
    };

    programs.tmux = {
      enable = true;
      mouse = true;
      clock24 = true;
      newSession = true;
      baseIndex = 1;
      escapeTime = 0;
      prefix = "C-a";
      terminal = "tmux-256color";
      historyLimit = 50000;
      customPaneNavigationAndResize = true;
      extraConfig = ''
        bind -n M-g display-popup -w 100% -E ${./t}
        source-file ${config.home.homeDirectory}/.config/tmux/${tmux-conf}
      '';
      plugins = with pkgs.tmuxPlugins; [
        {
          plugin = mkTmuxPlugin {
            name = "tmux-window-name";
            pluginName = "tmux-window-name";
            src = pkgs.fetchFromGitHub {
              owner = "ofirgall";
              repo = "tmux-window-name";
              rev = "f89e9c9d71f5a487e7276ff994cc6f7c1079c8ce";
              sha256 = "sha256-B9l9MX4XjUThzJwL4RZtlMg9yRzWbTIkY70F2/FIDc8=";
            };
            nativeBuildInputs = with pkgs; [ makeWrapper ];
            postInstall = ''
              wrapProgram $target/tmux_window_name.tmux \
                --prefix PATH : ${
                  with pkgs;
                  lib.makeBinPath ([ python39 python39Packages.libtmux ])
                }
            '';

          };
          extraConfig = ''set -g @tmux_window_name_use_tilde "True"'';
        }
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
  };
}
