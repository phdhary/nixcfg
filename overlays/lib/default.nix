{
  lib,
  config,
  ...
} @ args: let
  inherit (lib) recursiveUpdate;
  importLib = args:
    builtins.listToAttrs
    (builtins.map (f: (import (./. + "/${f}") args))
      (builtins.filter (f: f != "default.nix")
        (builtins.attrNames
          (builtins.readDir ./.))));
in
  final: prev: {
    lib = recursiveUpdate prev.lib (importLib args);
  }
