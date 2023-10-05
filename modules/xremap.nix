{ inputs, ... }:
if inputs ? xremap-flake then
  inputs.xremap-flake.homeManagerModules.default
else
  { }
