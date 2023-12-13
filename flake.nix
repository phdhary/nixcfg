{
  description = "Nix Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-23-11.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
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
    st.url = "github:siduck/st";
    mydwm = {
      # url = "git+file:../../development/linux/suckless/dwm-git";
      url = "github:phdhary/dwm";
    };
    # xremap-flake.url = "github:xremap/nix-flake";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      namespace = "laken";
      settings = {
        inherit system;
        config = { allowUnfree = true; };
      };
      pkgs = import nixpkgs (settings // {
        overlays = import ./overlays { inherit settings inputs; };
      });
      packages = self.outputs.packages.${system};
      lib = nixpkgs.lib // home-manager.lib;
    in {
      formatter.${system} = pkgs.nixfmt;
      packages.${system} = import ./packages pkgs;
      nixosConfigurations = {
        nixga = lib.nixosSystem {
          inherit system pkgs;
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/nixga ];
        };
      };
      homeConfigurations = {
        "laken-dev" = lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs packages namespace self; };
          modules = (import ./modules/hm pkgs)
            ++ [ (import ./home/laken/dev.nix) ];
        };
        "dude-nixga" = lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs packages namespace self; };
          modules = (import ./modules/hm pkgs)
            ++ [ (import ./home/dude/nixga.nix) ];
        };
      };
    };
}
