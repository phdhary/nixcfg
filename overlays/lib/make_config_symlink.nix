{config, ...}: let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (config.home.additionalUserInfo) hmConfigPath;
in {
  name = "makeConfigSymlink";
  # value = "why";
  value = parent_path: list_of_path:
    builtins.listToAttrs
    (builtins.map
      (file_path: {
        name = ".config/${file_path}";
        value = {
          source = mkOutOfStoreSymlink "${hmConfigPath}${parent_path}${file_path}";
        };
      })
      list_of_path);
}
