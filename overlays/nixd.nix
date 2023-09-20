{
  config,
  nixd,
  ...
}: {
  nixpkgs.overlays = let
    inherit (config.nixpkgs) system;
    inherit (nixd.packages.${system}) nixd;
  in [
    (final: prev: {inherit nixd;})
  ];
}
