pkgs:
let name = "note-taker";
in {
  ${name} = pkgs.stdenv.mkDerivation {
    inherit name;
    src = ./.;
    buildInputs = [ pkgs.neovim ];
    installPhase = ''
      mkdir -p $out/bin;
      cp -v ${name}.sh $out/bin/${name}
      substituteInPlace $out/bin/${name} \
        --replace @nvim@ ${pkgs.neovim}/bin/nvim;
    '';
  };
}
