{ config, lib, namespace, pkgs, ... }:
let cfg = config.${namespace}.programs.zathura;
in {
  options.${namespace}.programs.zathura = {
    enable = lib.mkEnableOption "zathura";
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.zathura;
    };
  };
  config = lib.mkIf cfg.enable {
    programs.zathura = {
      enable = true;
      package = cfg.package;
      options = {
        window-title-basename = true;
        statusbar-home-tilde = true;
        font = "SF Pro Display 13";
      };
    };
    home.packages = with pkgs.zathuraPkgs; [
      zathura_cb
      zathura_djvu
      zathura_pdf_poppler
      zathura_ps
    ];
  };
}
