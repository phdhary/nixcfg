{config, ...}: let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (config.home.additionalUserInfo) hmConfigPath;
in {
  name = "makeConfigSymlink";
  value = parent_path: file_path: {
    ".config/${file_path}".source = mkOutOfStoreSymlink "${hmConfigPath}${parent_path}${file_path}";
  };
}
