{
  config,
  nixd,
  ...
}: {
  nixpkgs.overlays = let
    inherit (config.nixpkgs) system;
  in [
    (final: prev: {
      nixd = nixd.packages.${system}.nixd;
    })
  ];
}
