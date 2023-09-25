{pkgs, ...}: let
  inherit (pkgs.lib) makeConfigSymlink;
  parentPath = "/home/terminal-emulators/";
in {
  imports = [
    ./wezterm
  ];

  home.file =
    makeConfigSymlink parentPath "kitty/kitty.conf"
    // makeConfigSymlink parentPath "kitty/scrollback-pager/init.lua"
    // makeConfigSymlink parentPath "kitty/themes/";

  programs.alacritty = {
    enable = true;
    package = pkgs.unstable.alacritty;
  };
}
