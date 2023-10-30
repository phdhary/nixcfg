{ config, lib, namespace, pkgs, ... }:
let cfg = config.${namespace}.programs.vscode;
in {
  options.${namespace}.programs.vscode = {
    enable = lib.mkEnableOption "visual studio code";
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.unstable.vscode;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = cfg.package;
      extensions = with pkgs.nix-vscode-extensions.vscode-marketplace; [
        aaron-bond.better-comments
        albert.tabout
        bradlc.vscode-tailwindcss
        christian-kohler.npm-intellisense
        christian-kohler.path-intellisense
        dart-code.dart-code
        dart-code.flutter
        dsznajder.es7-react-js-snippets
        eamodio.gitlens
        esbenp.prettier-vscode
        felixangelov.bloc
        golang.go
        hediet.vscode-drawio
        kisstkondoros.vscode-gutter-preview
        localizely.flutter-intl
        luanpotter.dart-import
        mikestead.dotenv
        ms-azuretools.vscode-docker
        ms-python.isort
        ms-vscode-remote.remote-containers
        ms-vscode-remote.remote-ssh
        ms-vscode-remote.remote-ssh-edit
        ms-vscode.remote-explorer
        naco-siren.gradle-language
        nash.awesome-flutter-snippets
        pkief.material-icon-theme
        redhat.vscode-yaml
        robert-brunhage.flutter-riverpod-snippets
        rust-lang.rust-analyzer
        sleistner.vscode-fileutils
        svelte.svelte-vscode
        usernamehw.errorlens
        vadimcn.vscode-lldb
        visualstudioexptteam.intellicode-api-usage-examples
        visualstudioexptteam.vscodeintellicode
        vscodevim.vim
        vue.volar
      ];
    };

    # xdg.desktopEntries."code" = {
    #   actions = {
    #     new-empty-window = {
    #       exec = "NIXOS_OZONE_WL=1 code --new-window %F";
    #       icon = "vscode";
    #       name = "New Empty Window";
    #     };
    #   };
    #   categories = ["Utility" "TextEditor" "Development" "IDE"];
    #   comment = "Code Editing. Redefined.";
    #   exec = "NIXOS_OZONE_WL=1 code %F";
    #   name = "Visual Studio Code";
    #   genericName = "Text Editor";
    #   icon = "vscode";
    #   mimeType = ["text/plain" "inode/directory"];
    #   startupNotify = true;
    #   type = "Application";
    # };
  };
}
