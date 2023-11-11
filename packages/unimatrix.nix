{ pkgs, ... }: {
  unimatrix = let name = "unimatrix";
  in pkgs.stdenv.mkDerivation {
    inherit name;
    src = pkgs.fetchFromGitHub {
      owner = "will8211";
      repo = name;
      rev = "65793c237553bf657af2f2248d2a2dc84169f5c4";
      sha256 = "sha256-fiaVEc0rtZarUQlUwe1V817qWRx4LnUyRD/j2vWX5NM=";
    };
    installPhase = ''
      mkdir -p $out/bin;
      mv ${name}.py $out/bin/${name};
      chmod +x $out/bin/${name};
    '';
  };
}
