{ config, namespace, pkgs, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (pkgs.lib) nameValuePair;
  inherit (config.${namespace}.additionalUserInfo) hmConfigPath;
  inherit (builtins) listToAttrs map;
in final: prev: {
  lib = prev.lib // {
    mkSymlinkFromList = { relativePath, paths, }:
      listToAttrs (map (filePath:
        (nameValuePair "${filePath}" {
          source =
            mkOutOfStoreSymlink "${hmConfigPath}${relativePath}${filePath}";
        })) paths);
    mkConfigSymlinkFromList = { relativePath, paths, }:
      listToAttrs (map (filePath:
        (nameValuePair ".config/${filePath}" {
          source =
            mkOutOfStoreSymlink "${hmConfigPath}${relativePath}${filePath}";
        })) paths);
  };
}
