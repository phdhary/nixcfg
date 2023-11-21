pkgs: {
  dwm = (pkgs.dwm.override {
    conf = builtins.readFile ./config_dwm.h;
  }).overrideAttrs (prev: {
    src = pkgs.fetchFromGitHub {
      owner = "phdhary";
      repo = "dwm";
      rev = "latest";
      sha256 = "sha256-jIxinAR12ck1xEk11Tz5wkRkCi7f1VjckcECBepSS0Y=";
    };
    prePatch = prev.prePatch + ''
      rm -rf config.h
    '';
  });
  slstatus = (pkgs.slstatus.override {
    conf = builtins.readFile ./config_slstatus.h;
  }).overrideAttrs {
    version = "1.0";
    src = pkgs.fetchgit {
      url = "https://git.suckless.org/slstatus";
      rev = "1.0";
      hash = "sha256-cFah6EgApslLSlJaOy/5W9ZV9Z1lzfKye/rRh9Om3T4=";
    };
  };
}
