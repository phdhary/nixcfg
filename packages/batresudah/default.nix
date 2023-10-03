pkgs:
let
  name = "batresudah";
  inherit (pkgs.stdenv) mkDerivation;
in {
  ${name} = mkDerivation {
    inherit name;
    src = ./.;
    buildInputs = [ pkgs.upower ];
    installPhase = ''
      mkdir -p $out/bin;
      cp -v batresudah.sh $out/bin/batresudah
      substituteInPlace $out/bin/batresudah \
        --replace @upower@ ${pkgs.upower}/bin/upower;
    '';
  };
}
