pkgs: {
  dwm = (pkgs.dwm.overrideAttrs { src = ./src; }).override {
    patches = [
    ];
  };
}
