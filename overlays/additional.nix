{ settings, inputs, ... }:
let
  inherit (settings) system;
  inherit (inputs) nixd nix-vscode-extensions flake-firefox-nightly st mydwm;
  inherit (inputs) nixpkgs-unstable nixpkgs-23-11;
in (final: prev: {
  unstable = import nixpkgs-unstable settings;
  nixpkgs-23-11 = import nixpkgs-23-11 settings;
  nixd = nixd.packages.${system}.nixd;
  st-snazzy = st.packages.${system}.st-snazzy;
  mydwm = mydwm.packages.${system}.default;
  nix-vscode-extensions = nix-vscode-extensions.extensions.${system};
  flake-firefox-nightly = flake-firefox-nightly.packages.${system};
})
