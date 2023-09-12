{
  description = "Nix - Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
    config = {allowUnfree = true;};
    pkgs = import nixpkgs {inherit system config;};
    unstable = import nixpkgs-unstable {inherit system config;};
  in {
    homeConfigurations."laken" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [./home];
      extraSpecialArgs = {inherit unstable;};
    };
  };
}
