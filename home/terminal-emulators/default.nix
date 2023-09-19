{pkgs, ...}: let
  inherit (pkgs.lib) makeConfigSymlink;
  thisPath = "/home/terminal-emulators/";
in {
  home.file =
    makeConfigSymlink thisPath "kitty/"
    // makeConfigSymlink thisPath "wezterm/";
}
