{ pkgs, ... }:
let
  name = "fvm";
  owner = "leoafarias";
  version = "3.0.0-beta.5";
  system-attrs = {
    x86_64-linux = "x64";
    aarch64-linux = "arm64";
    dumb = "dummb";
  };
  system = let
    inherit (builtins) filter attrNames head;
    currentSystem =
      head (filter (a: a == pkgs.system) (attrNames system-attrs));
  in system-attrs.${currentSystem};
in {
  fvm = pkgs.stdenv.mkDerivation {
    inherit name version;
    src = fetchTarball {
      url =
        "https://github.com/${owner}/${name}/releases/download/${version}/${name}-${version}-linux-${system}.tar.gz";
      sha256 = "sha256:00cd68xfg22xq1brkqlc4iwaxw2vbv5r6ad3h4k0q0cynfl0mfm5";
    };
    installPhase = ''
      mkdir -p $out/bin
      mv fvm $out/bin/fvm
      mv src/ $out/bin/src/
    '';
  };
}
