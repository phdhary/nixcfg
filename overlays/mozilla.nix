{nixpkgs-mozilla, ...}: let
  inherit (nixpkgs-mozilla.overlays) firefox;
in {
  nixpkgs.overlays = [firefox];
}
