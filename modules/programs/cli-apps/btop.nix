{
  config,
  namespace,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  name = "btop";
  cfg = config.${namespace}.programs.cli-apps.${name};
in {
  options.${namespace}.programs.cli-apps.${name} = {
    enable = mkEnableOption "${name}";
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
