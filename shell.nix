let
  lock-file = builtins.readFile ./flake.lock;
  flake-lock = builtins.fromJSON lock-file;
  inherit (flake-lock) nodes;

  from_lock = lock:
    let
      inherit (lock.original) type owner repo;
      inherit (lock.locked) rev narHash;
    in builtins.fetchTarball {
      url = "https://${type}.com/${owner}/${repo}/archive/${rev}.tar.gz";
      sha256 = narHash;
    };

  system = "x86_64-linux";
  config = { allowUnfree = true; };

  nixpkgs = from_lock nodes.nixpkgs;
  nixpkgs-unstable =
    import (from_lock nodes.nixpkgs-unstable) { inherit system config; };
  # rust-mozilla = import "${from_lock nodes.nixpkgs-mozilla}/rust-overlay.nix";
  pkgs = import nixpkgs {
    inherit system config;
    overlays = [
      (final: prev: {
        unstable = nixpkgs-unstable;
        nixgl = import (from_lock nodes.nixgl) { inherit pkgs; };
      })
    ];
  };
in {
  # inherit pkgs;
  default = pkgs.mkShell {
    name = "playground";
    packages = with pkgs; [ xorg.xev gucharmap imv];
  };
}
