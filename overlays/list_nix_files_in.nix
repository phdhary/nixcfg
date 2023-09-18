# here is how to add to nixpkgs lib using overlays
pkgs: {
  nixpkgs.overlays = [
    (
      final: prev: {
        lib =
          pkgs.lib.recursiveUpdate
          prev.lib
          {
            listNixFilesIn = dir: exclude:
              pkgs.lib.mapAttrsToList
              (name: _: "./${name}")
              (
                pkgs.lib.filterAttrs (name: _: (pkgs.lib.hasSuffix ".nix" name) && (exclude != name))
                (builtins.readDir dir)
              );
          };
      }
    )
  ];
}
