pkgs:
let
  mkSimpleScript = name:
    pkgs.writeShellScriptBin name (builtins.readFile ./${name}.sh);
in {
  hm-cleanup = mkSimpleScript "hm-cleanup";
  tswitch = mkSimpleScript "tswitch";
  rofi-utility = let name = "rofi-utility";
  in pkgs.stdenv.mkDerivation {
    inherit name;
    src = ./.;
    installPhase = ''
      mkdir -p $out/bin;
      cp -v ${name}.sh $out/bin/${name}
      substituteInPlace $out/bin/${name} \
        --replace @rofi-pulse-select@ ${pkgs.rofi-pulse-select}/bin/rofi-pulse-select \
        --replace @rofi-bluetooth@ ${pkgs.rofi-bluetooth}/bin/rofi-bluetooth \
        --replace @redshift@ ${pkgs.redshift}/bin/redshift; 
    '';
  };
  batresudah = let name = "batresudah";
  in pkgs.stdenv.mkDerivation {
    inherit name;
    src = ./.;
    installPhase = ''
      mkdir -p $out/bin;
      cp -v ${name}.sh $out/bin/${name}
      substituteInPlace $out/bin/${name} \
        --replace @upower@ ${pkgs.upower}/bin/upower;
    '';
  };
  note-taker = let name = "note-taker";
  in pkgs.stdenv.mkDerivation {
    inherit name;
    src = ./.;
    installPhase = ''
      mkdir -p $out/bin;
      cp -v ${name}.sh $out/bin/${name}
      substituteInPlace $out/bin/${name} \
        --replace @nvim@ ${pkgs.neovim}/bin/nvim;
    '';
  };
  dyetide = pkgs.stdenv.mkDerivation {
    name = "dyetide";
    src = pkgs.fetchgit {
      url = "https://codeberg.org/z3rOR0ne/dyetide";
      sha256 = "sha256-6tIdzfwM//AufQ3xsZRoHKaaXSrHMHmKngtGXzT8u5Q=";
    };
    installPhase = ''
      install -Dm755 dyetide $out/bin/dyetide
      install -Dm755 dye $out/bin/dye
    '';
  };
  dunst-volume = let name = "dunst-volume";
  in pkgs.stdenv.mkDerivation {
    inherit name;
    src = ./.;
    installPhase = ''
      mkdir -p $out/bin;
      cp -v ${name}.sh $out/bin/${name}
      substituteInPlace $out/bin/${name} \
        --replace @pamixer@ ${pkgs.pamixer}/bin/pamixer;
    '';
  };
  dunst-brightness = let name = "dunst-brightness";
  in pkgs.stdenv.mkDerivation {
    inherit name;
    src = ./.;
    installPhase = ''
      mkdir -p $out/bin;
      cp -v ${name}.sh $out/bin/${name}
      substituteInPlace $out/bin/${name} \
        --replace @brightnessctl@ ${pkgs.brightnessctl}/bin/brightnessctl;
    '';
  };
}
