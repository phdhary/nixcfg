{
  lib,
  config,
  ...
} @ args: let
  inherit (lib) recursiveUpdate;
  dude = args:
    builtins.listToAttrs
    (builtins.map (f: (import (./. + "/${f}") args))
      (builtins.filter (f: f != "default.nix")
        (builtins.attrNames
          (builtins.readDir ./.))));
in
  final: prev: {
    lib = recursiveUpdate prev.lib (dude args);
  }
