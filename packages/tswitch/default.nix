pkgs:
let name = "tswitch";
in { ${name} = pkgs.writeShellScriptBin name (builtins.readFile ./${name}.sh); }
