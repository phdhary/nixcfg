{ pkgs, ... }: {
  sf-pro-fonts = pkgs.stdenvNoCC.mkDerivation {
    name = "sf-pro-fonts";
    src = pkgs.fetchFromGitHub {
      owner = "sahibjotsaggu";
      repo = "San-Francisco-Pro-Fonts";
      rev = "8bfea09aa6f1139479f80358b2e1e5c6dc991a58";
      sha256 = "sha256-mAXExj8n8gFHq19HfGy4UOJYKVGPYgarGd/04kUIqX4=";
    };
    installPhase = ''
      runHook preInstall

      mkdir -p $out/share/fonts/opentype
      cp *.otf $out/share/fonts/opentype

      runHook postInstall
    '';
  };
  legacy-computing-font = pkgs.stdenvNoCC.mkDerivation {
    name = "legacy_computing-font";
    src = pkgs.fetchurl {
      url =
        "https://github.com/dokutan/legacy_computing-font/releases/download/v1.1/LegacyComputing.ttf";
      sha256 = "sha256-VVWg4dJYDEtPngKPlXT3wUtH4w9/Kk3UV+rlCg7lmFI=";
    };
    dontUnpack = true;
    installPhase = ''
      mkdir -p $out/share/fonts/truetype
      cp $src $out/share/fonts/truetype/LegacyComputing.ttf
    '';
  };
}
