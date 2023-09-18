{
  description = "Nix - Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    nix-vscode-extensions,
    ...
  }: let
    system = "x86_64-linux";
    user = "laken";
    config = {allowUnfree = true;};
    pkgs = import nixpkgs {inherit system config;};
    unstable = import nixpkgs-unstable {inherit system config;};
    vsc-extensions = nix-vscode-extensions.extensions.${system};
  in {
    homeConfigurations."${user}" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {inherit unstable vsc-extensions;};
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
