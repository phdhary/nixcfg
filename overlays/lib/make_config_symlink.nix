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
  name = "mkConfigSymlink";
  value = parent_path: list_of_path:
    builtins.listToAttrs
    (builtins.map
      (
        file_path: (
          nameValuePair ".config/${file_path}"
          {source = mkOutOfStoreSymlink "${hmConfigPath}${parent_path}${file_path}";}
        )
      )
      list_of_path);
}
