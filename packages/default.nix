pkgs: 
builtins.listToAttrs
(builtins.map (f: (import (./. + "/${f}") pkgs))
  (builtins.filter (f: f != "default.nix")
    (builtins.attrNames (builtins.readDir ./.))))
