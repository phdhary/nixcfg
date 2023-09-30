pkgs: {
  format = pkgs.writeShellScriptBin "format.sh" ''
    nix fmt ./*.nix ./*/*.nix ./*/*/*.nix ./*/*/*/*.nix ./*/*/*/*/*.nix
  '';
}
