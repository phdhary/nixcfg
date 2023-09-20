{
  config,
  nix-vscode-extensions,
  ...
}: {
  nixpkgs.overlays = let
    inherit (config.nixpkgs) system;
  in [
    (final: prev: {
      nix-vscode-extensions = nix-vscode-extensions.extensions.${system};
    })
  ];
}
