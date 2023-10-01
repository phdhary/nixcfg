pkgs:
let
  inherit (pkgs.lib) hasSuffix;
  inherit (pkgs.lib.attrsets) mergeAttrsList;
  inherit (pkgs.lib.filesystem) listFilesRecursive;
  inherit (builtins) map filter;
in mergeAttrsList (map (f: import f pkgs)
  (filter (f: (hasSuffix ".nix" f) && f != ./default.nix)
    (listFilesRecursive ./.)))
