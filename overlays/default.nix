{
  config,
  nixpkgs-unstable,
  ...
}: {
  imports = [
    ./mozilla.nix
    ./bool_checks.nix
    ./make_path.nix
    ./nixd.nix
    ./nix-vscode-extensions.nix
  ];

  nixpkgs.overlays = let
    inherit (config.nixpkgs) system;
  in [
    (final: prev: {
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    })
  ];
}
