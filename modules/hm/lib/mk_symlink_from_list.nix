{ config, lib, namespace, pkgs, self, ... }:
let
  inherit (lib) nameValuePair;
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (config.${namespace}.lib) hmConfigPath runtimePath;
  inherit (builtins) listToAttrs map;
  inherit (pkgs.lib.filesystem) listFilesRecursive;
  mkCustomLib = fn:
    (lib.mkOption {
      type = lib.types.anything;
      default = fn;
    });
in {
  options.${namespace}.lib = {

    mkSymlinkFromList = mkCustomLib ({ relativePath, paths, }:
      listToAttrs (map (filePath:
        (nameValuePair filePath {
          source =
            mkOutOfStoreSymlink "${hmConfigPath}/${relativePath}/${filePath}";
        })) paths));

    mkConfigSymlinkFromList = mkCustomLib ({ relativePath, paths, }:
      listToAttrs (map (filePath:
        (nameValuePair ".config/${filePath}" {
          source =
            mkOutOfStoreSymlink "${hmConfigPath}/${relativePath}/${filePath}";
        })) paths));

    mkXdgConfigLink = mkCustomLib ({ relativePath, directory, paths, }:
      listToAttrs (map (filePath:
        (nameValuePair "${directory}/${filePath}" {
          source = mkOutOfStoreSymlink
            "${hmConfigPath}/${relativePath}/${directory}/${filePath}";
        })) paths));

    recursiveSymlink = mkCustomLib ({ path, directory, filter }:
      let
        list = listFilesRecursive path;
        filtered = filter list;
        results = (map (f:
          (nameValuePair
            "${directory}${lib.removePrefix (toString path) (toString f)}" {
              source = mkOutOfStoreSymlink (runtimePath f);
            })) filtered);
      in listToAttrs results);

    runtimePath = mkCustomLib (path:
      let
        runtimeRoot = hmConfigPath;
        rootStr = toString self;
        pathStr = toString path;
      in assert lib.assertMsg (lib.hasPrefix rootStr pathStr)
        "${pathStr} does not start with ${rootStr}";
      runtimeRoot + lib.removePrefix rootStr pathStr);
  };
}
