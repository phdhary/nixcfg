{
  description = "Nix Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable-fdd89.url =
      "github:nixos/nixpkgs/fdd898f8f79e8d2f99ed2ab6b3751811ef683242";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixd = {
      url = "github:nix-community/nixd";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl = {
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-firefox-nightly = {
      url = "github:nix-community/flake-firefox-nightly";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # xremap-flake.url = "github:xremap/nix-flake";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      user = "laken";
      namespace = "laken";
      settings = {
        inherit system;
        config = { allowUnfree = true; };
      };
      pkgs = import nixpkgs (settings // {
        overlays = import ./overlays { inherit settings inputs; };
      });
      packages = self.outputs.packages.${system};
    in {
      formatter.${system} = pkgs.nixfmt;
      packages.${system} = import ./packages pkgs;
      nixosConfigurations = {
        nixga = nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          specialArgs = { inherit inputs user; };
          modules = [ ./hosts/nixga ];
        };
      };
      homeConfigurations = {
        "${user}" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs packages user namespace; };
          modules = (import ./modules/home-manager pkgs)
            ++ [ (import ./home/laken/nixga.nix) ];
        };
      };
    };
}
