pkgs:
let name = "hm-cleanup";
in { ${name} = pkgs.writeShellScriptBin name (builtins.readFile ./${name}.sh); }
