{inputs, ...}: let
  inherit (inputs.nixpkgs-mozilla.overlays) firefox;
in {
  nixpkgs.overlays = [firefox];
}
