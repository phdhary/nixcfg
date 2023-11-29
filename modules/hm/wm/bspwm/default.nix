{ config, lib, namespace, pkgs, ... }:
let
  cfg = config.${namespace}.wm.bspwm;
  inherit (config.${namespace}.lib) recursiveSymlink;
in {
  options.${namespace}.wm.bspwm.enable = lib.mkEnableOption "bspwm";
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ bspwm bsp-layout xtitle ];
    xdg.configFile = recursiveSymlink {
      directory = "bspwm";
      path = ./.;
      filter = list:
        lib.filter (f:
          (!lib.hasSuffix ".nix" f) && (!lib.hasInfix "current_border_color" f))
        list;
    };
    ${namespace}.programs = {
      dunst.enable = true;
      picom.enable = true;
      polybar.enable = true;
      sxhkd = {
        enable = true;
        enable-bspwm-mappings = true;
      };
      xob.enable = true;
    };
    home.activation.generateBspwmStateFile =
      lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        target_dir=~/.local/state/bspwm
        if [ ! -f $target_dir/current_border_color ]; then
          mkdir -p $target_dir
          cp ${
            builtins.toPath ./current_border_color
          } $target_dir/current_border_color
          chmod +x $target_dir/current_border_color
        fi
      '';
  };
}
