{
  config,
  namespace,
  pkgs,
  ...
}: let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (pkgs.lib) nameValuePair;
  inherit (config.${namespace}.additionalUserInfo) hmConfigPath;
in {
  name = "mkSymlinkFromList";
  value = {
    relativePath,
    paths,
  }:
    builtins.listToAttrs
    (builtins.map
      (
        filePath: (
          nameValuePair "${filePath}"
          {source = mkOutOfStoreSymlink "${hmConfigPath}${relativePath}${filePath}";}
        )
      )
      paths);
}
