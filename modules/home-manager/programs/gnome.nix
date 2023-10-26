{ config, pkgs, namespace, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.programs.gnome-packs;
in {
  options.${namespace}.programs.gnome-packs = {
    enable = mkEnableOption "gnome";
  };
  config = mkIf cfg.enable {
    # dconf.settings."org/gnome/shell".enabledExtensions = { };
    home.packages = with pkgs; [
      adw-gtk3
      gnome-solanum
      gnome-browser-connector
      gnome44Extensions."advanced-alt-tab@G-dH.github.com"
      gnome44Extensions."appindicatorsupport@rgcjonas.gmail.com"
      gnome44Extensions."flypie@schneegans.github.com"
      gnome44Extensions."blur-my-shell@aunetx"
      gnome44Extensions."caffeine@patapon.info"
      gnome44Extensions."forge@jmmaranan.com"
      gnome44Extensions."runcat@kolesnikov.se"
      gnome44Extensions."legacyschemeautoswitcher@joshimukul29.gmail.com"
      gnome44Extensions."mousefollowsfocus@matthes.biz"
      gnome44Extensions."pano@elhan.io"
      gnome44Extensions."space-bar@luchrioh"
      gnome44Extensions."tiling-assistant@leleat-on-github"
      gnome44Extensions."unite@hardpixel.eu"
      gnome44Extensions."just-perfection-desktop@just-perfection"
      gnome44Extensions."arcmenu@arcmenu.com"
      unstable.gnome44Extensions."sane-airplane-mode@kippi"
      unstable.gnome44Extensions."search-light@icedman.github.com"
      # unstable-fdd89.gnome44Extensions."gsconnect@andyholmes.github.io" # doesn't work
    ];
  };
}
