{pkgs, ...}: let
  inherit (pkgs.lib) makeConfigSymlink;
  thisPath = "/home/terminal-emulators/";
in {
  home.file =
    # makeConfigSymlink thisPath "kitty/"
    makeConfigSymlink thisPath "kitty/kitty.conf"
    // makeConfigSymlink thisPath "kitty/scrollback-pager/init.lua"
    // makeConfigSymlink thisPath "kitty/themes/"
    // makeConfigSymlink thisPath "wezterm/colors/"
    // makeConfigSymlink thisPath "wezterm/config/";

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

  xdg.desktopEntries."my.dude.ncmpcpp" = {
    name = "ncmpcpp";
    comment = "ncmpcpp cli app";
    icon = "io.bassi.Amberol";
    exec = "launch-ncmpcpp";
    categories = ["AudioVideo" "Music" "Audio" "ConsoleOnly"];
    terminal = true;
  };
}
