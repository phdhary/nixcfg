pkgs:
let name = "batresudah";
in { ${name} = pkgs.writeShellScriptBin name (builtins.readFile ./${name}.sh); }
