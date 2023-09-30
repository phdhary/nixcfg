args@{ user, pkgs, ... }: {
  home = {
    stateVersion = "23.05";
    username = "${user}";
    homeDirectory = "/home/${user}";
  };

  nix = {
    package = pkgs.nix;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs = {
    overlays = import ../../overlays args;
    config = { allowUnfree = true; };
  };

  xdg.configFile."nixpkgs/config.nix".text = "{allowUnfree=true;}";

  imports = [ ../../home.nix ];
}
