pkgs: let
  name = "batresudah";
in {
  inherit name;
  value = pkgs.writeShellScriptBin name (builtins.readFile ./${name}.sh);
}
