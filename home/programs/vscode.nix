{
  unstable,
  vsc-extensions,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = unstable.vscode;
    extensions = with vsc-extensions.vscode-marketplace; [
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
}
