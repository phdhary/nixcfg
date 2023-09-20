{pkgs, ...}: let
  inherit (pkgs.lib) makeConfigSymlink;
  thisPath = "/home/terminal-emulators/";
in {
  home.file =
    # makeConfigSymlink thisPath "kitty/"
    makeConfigSymlink thisPath "kitty/kitty.conf"
    // makeConfigSymlink thisPath "kitty/scrollback-pager/init.lua"
    // makeConfigSymlink thisPath "kitty/themes/"
    // makeConfigSymlink thisPath "wezterm/";
}
