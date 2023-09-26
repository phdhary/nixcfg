{
  config,
  lib,
  ...
}: let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (lib) mkIf mkMerge;
  inherit (config.home.additionalUserInfo) hmConfigPath;
in {
  name = "makeConfigSymlink2";
  value = "why";
  # value = parent_path: list_of_path:
  #   builtins.listToAttrs
  #   (builtins.map
  #     (file_path: {
  #       name = ".config/${file_path}.source";
  #       value = mkOutOfStoreSymlink "${hmConfigPath}${parent_path}${file_path}";
  #     })
  #     list_of_path);
}
# home.file=makeConfigSymlink2 parentPath [
# "kitty/kitty.conf"
# "kitty/theme.conf"
# ]

