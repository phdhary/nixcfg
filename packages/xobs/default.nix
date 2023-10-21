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
  xob_volume = mkScript "volume" "pamixer" pkgs.pamixer;
  xob_brightness = mkScript "brightness" "brightnessctl" pkgs.brightnessctl;
  xob_server = mkScript "server" "xob" pkgs.xob;
}
