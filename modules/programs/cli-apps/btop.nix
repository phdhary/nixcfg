{
  config,
  namespace,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.${namespace}.programs.cli-apps.btop;
in {
  options.${namespace}.programs.cli-apps.btop = {
    enable = mkEnableOption "btop";
  };

  config = mkIf cfg.enable {
    programs.btop = {
      enable = true;
      settings = {
        color_theme = "TTY";
        theme_background = false;
        truecolor = true;
        force_tty = false;
        vim_keys = true;
        rounded_corners = false;
        graph_symbol = "braille";
        shown_boxes = "proc cpu";
        show_disks = false;
        update_ms = 1000;
        proc_sorting = "cpu direct";
      };
    };
  };
}
