{ config, lib, namespace, pkgs, ... }:
let
  cfg = config.${namespace}.programs.polybar;
  inherit (config.${namespace}.lib) recursiveSymlink;
  inherit (lib) hasSuffix hasInfix;
in {
  options.${namespace}.programs.polybar = {
    enable = lib.mkEnableOption "polybar";
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.polybarFull;
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
    home.activation.generatePolybarStateFile =
      lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        target_dir=~/.local/state/polybar
        if [ ! -f $target_dir/current.ini ]; then
          mkdir -p $target_dir
          cp ${builtins.toPath ./current.ini} $target_dir/current.ini
        fi
      '';
    xdg.configFile = recursiveSymlink {
      directory = "polybar";
      path = ./.;
      filter = list:
        builtins.filter (f: (!hasSuffix ".nix" f) && (!hasInfix "current" f))
        list;
    };
  };
}
