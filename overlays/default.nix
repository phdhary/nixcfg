{
  config,
  inputs,
  lib,
  ...
}: let
  inherit (config.nixpkgs) system;
  inherit (config.nixpkgs.config) allowUnfree;
  inherit (inputs) nixd nixpkgs-unstable nixpkgs-mozilla nix-vscode-extensions nixgl;
in [
  (_: _: {
    unstable = import nixpkgs-unstable {
      inherit system;
      config = {inherit allowUnfree;};
    };
    nixd = nixd.packages.${system}.nixd;
    nix-vscode-extensions = nix-vscode-extensions.extensions.${system};
  })
  (import ./bool_checks.nix {inherit lib;})
  (import ./make_path.nix {inherit config lib;})
  nixpkgs-mozilla.overlays.firefox
  nixgl.overlay
]
