pkgs: {
  dwm = pkgs.mydwm;
  slstatus = (pkgs.slstatus.override {
    conf = builtins.readFile ./config_slstatus.h;
  }).overrideAttrs (prev: rec {
    version = "1.0";
    src = pkgs.fetchgit {
      url = "https://git.suckless.org/slstatus";
      rev = version;
      hash = "sha256-cFah6EgApslLSlJaOy/5W9ZV9Z1lzfKye/rRh9Om3T4=";
    };
    preBuild = prev.preBuild + (let file = "components/battery.c";
    in ''
      sed -i '59s/\+/󰂄⇡/' ${file}
      sed -i '60s/\-/󰁹⇣/' ${file}
      sed -i '61s/"o"/"󱟢"/' ${file}
      sed -i '62s/"o"/"󱟢"/' ${file}
      sed -i '158s/\+/󰂄⇡/' ${file}
      sed -i '159s/\-/󰁹⇣/' ${file}
    '');
  });
  st = pkgs.st-snazzy.override { conf = builtins.readFile ./config_st.h; };
}
