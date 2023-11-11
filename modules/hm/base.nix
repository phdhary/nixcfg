{ pkgs, inputs, lib, ... }:
let inherit (inputs.nixpkgs.lib) mkDefault;
in {
  home = {
    stateVersion = mkDefault "23.05";
    username = mkDefault "laken";
    homeDirectory = mkDefault "/home/laken";
  };

  nix = {
    package = pkgs.nix;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings = { warn-dirty = false; };
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
  };

  xdg.configFile."nixpkgs/config.nix".text = "{allowUnfree=true;}";
}
