args @ {user,pkgs, ...}: {
  home.stateVersion = "23.05";
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";
  nixpkgs.overlays = import ../overlays args;
  imports = builtins.map (f: ../home + "/${f}") (builtins.attrNames (builtins.readDir ../home));
}
