{ inputs, ... }:
final: prev: {
  compfy = prev.picom.overrideAttrs (oldAttrs: rec {
    pname = "compfy";
    version = "1.7.1";
    buildInputs = [ prev.pcre2 ] ++ oldAttrs.buildInputs;
    src = prev.fetchFromGitHub {
      owner = "allusive-dev";
      repo = "compfy";
      rev = version;
      hash = "sha256-FaGPT7qbMSpbpnWR82h7FgyAbz1isIJYl/z9rwpM1Tw=";
    };
    postInstall = "";
  });
}
