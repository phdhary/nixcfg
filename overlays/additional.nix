{
  config,
  inputs,
  ...
}: let
  inherit (config.nixpkgs) system;
  inherit (config.nixpkgs.config) allowUnfree;
  inherit (inputs) nixd nixpkgs-unstable nix-vscode-extensions;
in (
  final: prev: {
    unstable = import nixpkgs-unstable {
      inherit system;
      config = {inherit allowUnfree;};
    };
    nixd = nixd.packages.${system}.nixd;
    nix-vscode-extensions = nix-vscode-extensions.extensions.${system};
  }
)