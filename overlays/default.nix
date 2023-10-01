{ lib, ... }@args:
let
  inherit (lib) hasSuffix;
  inherit (lib.filesystem) listFilesRecursive;
  inherit (builtins) map filter;
in map (f: import f args)
(filter (f: (hasSuffix ".nix" f) && f != ./default.nix)
  (listFilesRecursive ./.))
