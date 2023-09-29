args: let
  overlays =
    builtins.map (f: (import (./. + "/${f}") args))
    (builtins.filter (f: f != "default.nix" && f != "lib")
      (builtins.attrNames (builtins.readDir ./.)));
  lib-overlays =
    builtins.map (f: (import (./lib + "/${f}") args))
    (builtins.attrNames (builtins.readDir ./lib));
in
  overlays ++ lib-overlays
