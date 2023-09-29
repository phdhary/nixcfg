pkgs: let
  name = "hm-cleanup";
in {
  inherit name;
  value = pkgs.writeShellScriptBin name (builtins.readFile ./${name}.sh);
}
