{ pkgs, ... }: {
  fonts = {
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
  };
}
