{ settings, inputs, ... }:
let
  inherit (settings) system;
  inherit (inputs) nixd nix-vscode-extensions flake-firefox-nightly;
  inherit (inputs) nixpkgs-unstable nixpkgs-unstable-fdd89;
in (final: prev: {
  unstable = import nixpkgs-unstable settings;
  unstable-fdd89 = import nixpkgs-unstable-fdd89 settings;
  nixd = nixd.packages.${system}.nixd;
  nix-vscode-extensions = nix-vscode-extensions.extensions.${system};
  latest = flake-firefox-nightly.packages.${system};
})
