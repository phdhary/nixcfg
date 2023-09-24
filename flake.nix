{
  description = "Nix - Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-mozilla.url = "github:mozilla/nixpkgs-mozilla";
    nixd = {
      url = "github:nix-community/nixd";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl = {
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
    user = "laken";
  in {
    homeConfigurations."${user}" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      extraSpecialArgs = {inherit inputs;};
      modules = [
        ./home
        ./home/extra_options.nix
        {
          home.username = "${user}";
          home.homeDirectory = "/home/${user}";
          home.stateVersion = "23.05";
        }
      ];
    };
  };
}
