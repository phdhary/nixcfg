{ config, lib, namespace, self, pkgs, ... }:
let
  inherit (builtins) listToAttrs map;
  inherit (config.${namespace}.lib) runtimePath;
  inherit (config.lib.file) mkOutOfStoreSymlink;
  mkCustomLib = fn:
    (lib.mkOption {
      type = lib.types.anything;
      default = fn;
    });
in {
  options.${namespace}.lib = {

    recursiveSymlink = mkCustomLib ({ path, directory, filter }:
      let
        list = lib.filesystem.listFilesRecursive path;
        filtered = filter list;
        results = (map (f:
          (lib.nameValuePair
            "${directory}${lib.removePrefix (toString path) (toString f)}" {
              source = mkOutOfStoreSymlink (runtimePath f);
            })) filtered);
      in listToAttrs results);

    runtimePath = mkCustomLib (path:
      let
        runtimeRoot = "${config.home.homeDirectory}/.config/nixcfg";
        rootStr = toString self;
        pathStr = toString path;
      in assert lib.assertMsg (lib.hasPrefix rootStr pathStr)
        "${pathStr} does not start with ${rootStr}";
      runtimeRoot + lib.removePrefix rootStr pathStr);

    wrapWithNixGLIntel = mkCustomLib (name: command:
      pkgs.writeShellScriptBin name ''
        if command -v "nixGLIntel" &> /dev/null; then
            nixGLIntel ${command} "$@"
        else
            ${command} "$@"
        fi
      '');
  };
}
