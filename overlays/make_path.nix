{
  lib,
  config,
  ...
}: {
  nixpkgs.overlays = let
    inherit (lib) recursiveUpdate;
    inherit (config.lib.file) mkOutOfStoreSymlink;
    inherit (config.home.additionalUserInfo) hmConfigPath;
  in [
    (final: prev: {
      lib = recursiveUpdate prev.lib {
        makeConfigSymlink = parent_path: file_path: {
          ".config/${file_path}".source = mkOutOfStoreSymlink "${hmConfigPath}${parent_path}${file_path}";
        };
      };
    })
  ];
}
