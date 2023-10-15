pkgs:
let
  a = pkgs.buildFHSEnv {
    name = "neovim";
    targetPkgs = pkgs: (with pkgs; [ neovim ]);
    runScript = "/usr/bin/nvim";
  };
in {
  neovim-fhs = a.overrideAttrs (final: prev: {
    # targetPkgs = pkgs: (with pkgs; [ neovim lua-language-server ]);
    runScript = "echo Hoi";
  });
  # neovim-fhs = a;
}
