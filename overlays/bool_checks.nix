{lib, ...}: {
  nixpkgs.overlays = let
    inherit (lib) recursiveUpdate;
    inherit (builtins) getEnv readFile filter isString split length head match;
  in [
    (final: prev: {
      lib = recursiveUpdate prev.lib {
        isWayland = getEnv "XDG_SESSION_TYPE" == "wayland";
        isOS = name: let
          osRelease = readFile "/etc/os-release";
          osLines = filter isString (split "\n" osRelease);
          safeHead = xs: if length xs == 0 then null else head xs;
          getOsField = key: safeHead (head (filter (x: x != null) (map (match key) osLines)));
          osId = getOsField "ID=(.+)";
        in
          osId == name;
      };
    })
  ];
}
