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
