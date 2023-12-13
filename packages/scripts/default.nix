pkgs:
let
  mkSimpleScript = name:
    pkgs.writeShellScriptBin name (builtins.readFile ./${name}.sh);
in {
  hm-cleanup = mkSimpleScript "hm-cleanup";
  tswitch = mkSimpleScript "tswitch";
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
