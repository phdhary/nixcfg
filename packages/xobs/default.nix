{ pkgs, ... }:
let
  mkScript = pname: replaceThis: withThis:
    pkgs.stdenv.mkDerivation rec {
      name = "xob_" + pname;
      src = ./.;
      installPhase = ''
        install -Dm755 ${pname}.sh $out/bin/${name};
        substituteInPlace $out/bin/${name} --replace @${replaceThis}@ ${withThis}/bin/${replaceThis};
      '';
    };
in {
  xobVolume = mkScript "volume" "pamixer" pkgs.pamixer;
  xobBrightness = mkScript "brightness" "brightnessctl" pkgs.brightnessctl;
  xobServer = mkScript "server" "xob" pkgs.xob;
}
