{ inputs, ... }@args:
let
  inherit (inputs.nixpkgs.lib) hasSuffix;
  inherit (inputs.nixpkgs.lib.filesystem) listFilesRecursive;
  inherit (builtins) map filter;
in map (f: import f args)
(filter (f: (hasSuffix ".nix" f) && f != ./default.nix)
  (listFilesRecursive ./.))
