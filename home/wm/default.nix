{pkgs, ...}: let
  inherit (pkgs.lib) makeConfigSymlink;
  thisPath = "/home/wm/";
in {
  home.file =
    makeConfigSymlink thisPath "avizo/config.ini"
    // makeConfigSymlink thisPath "i3/common.conf"
    // makeConfigSymlink thisPath "i3/config"
    // makeConfigSymlink thisPath "i3/picom.conf"
    // makeConfigSymlink thisPath "i3status-rust/config.toml"
    // makeConfigSymlink thisPath "i3status-rust/themes/roso.toml"
    // makeConfigSymlink thisPath "pop-shell/config.json"
    // makeConfigSymlink thisPath "rofi/config.rasi"
    // makeConfigSymlink thisPath "sway/config"
    // makeConfigSymlink thisPath "swaylock/config"
    // makeConfigSymlink thisPath "swaynag/config"
    // makeConfigSymlink thisPath "wofi/config"
    // makeConfigSymlink thisPath "wofi/style.css";
}
