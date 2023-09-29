let
  modules =
    builtins.map (f: (import (./. + "/${f}")))
    (builtins.filter (f: f != "default.nix" && f != "programs")
      (builtins.attrNames (builtins.readDir ./.)));
  programs-modules =
    builtins.map (f: (import (./programs + "/${f}")))
    (builtins.filter (f: f != "cli-apps")
      (builtins.attrNames (builtins.readDir ./programs)));
  programs-cli-apps-modules =
    builtins.map (f: (import (./programs/cli-apps + "/${f}")))
    (builtins.attrNames (builtins.readDir ./programs/cli-apps));
in
  modules ++ programs-modules ++ programs-cli-apps-modules
