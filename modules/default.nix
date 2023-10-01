pkgs:
let
  inherit (pkgs.lib) hasSuffix;
  inherit (pkgs.lib.filesystem) listFilesRecursive;
  inherit (builtins) map filter;
in map (f: import f) (filter (f: (hasSuffix ".nix" f) && f != ./default.nix)
  (listFilesRecursive ./.))
