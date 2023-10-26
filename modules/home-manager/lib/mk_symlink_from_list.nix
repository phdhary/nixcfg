{ config, namespace, pkgs, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (pkgs.lib) mkOption types nameValuePair;
  inherit (config.${namespace}.lib) hmConfigPath;
  inherit (builtins) listToAttrs map;
in {
  options.${namespace}.lib = {
    mkSymlinkFromList = mkOption {
      type = types.anything;
      default = { relativePath, paths, }:
        listToAttrs (map (filePath:
          (nameValuePair filePath {
            source =
              mkOutOfStoreSymlink "${hmConfigPath}/${relativePath}/${filePath}";
          })) paths);
    };
    mkConfigSymlinkFromList = mkOption {
      type = types.anything;
      default = { relativePath, paths, }:
        listToAttrs (map (filePath:
          (nameValuePair ".config/${filePath}" {
            source =
              mkOutOfStoreSymlink "${hmConfigPath}/${relativePath}/${filePath}";
          })) paths);
    };
    mkXdgConfigLink = mkOption {
      type = types.anything;
      default = { relativePath, directory, paths, }:
        listToAttrs (map (filePath:
          (nameValuePair "${directory}/${filePath}" {
            source = mkOutOfStoreSymlink
              "${hmConfigPath}/${relativePath}/${directory}/${filePath}";
          })) paths);
    };
  };
}
