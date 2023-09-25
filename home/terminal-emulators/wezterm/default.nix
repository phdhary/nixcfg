{pkgs, ...}: let
  inherit (pkgs.lib) makeConfigSymlink;
  parentPath = "/home/terminal-emulators/";
in {
  home.file =
    makeConfigSymlink parentPath "wezterm/colors/"
    // makeConfigSymlink parentPath "wezterm/config/";

  programs.wezterm = {
    enable = true;
    # package = pkgs.unstable.wezterm;
    package = let
      wezterm = "${pkgs.unstable.wezterm}/bin/wezterm start --cwd .";
      wrapped_wezterm = pkgs.writeShellScriptBin "wrapped_wezterm" ''
        if command -v "nixGLIntel" &> /dev/null; then
            nixGLIntel ${wezterm} "$@"
        else
            ${wezterm} "$@"
        fi
      '';
    in
      pkgs.symlinkJoin {
        name = "wezterm";
        paths = [
          wrapped_wezterm
          pkgs.unstable.wezterm
        ];
      };
    extraConfig = ''return require "config"'';
  };

  xdg.desktopEntries."org.wezfurlong.wezterm" = {
    name = "WezTerm";
    comment = "Wez's Terminal Emulator";
    icon = "org.wezfurlong.wezterm";
    exec = "wrapped_wezterm %F";
    categories = ["System" "TerminalEmulator" "Utility"];
    terminal = false;
  };
}
