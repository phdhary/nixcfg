{ pkgs, inputs, ... }:
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
  };

  xdg.configFile."nixpkgs/config.nix".text = "{allowUnfree=true;}";
}
