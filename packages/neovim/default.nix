pkgs: {
  neovim-fhs = pkgs.buildFHSEnv {
    name = "neovim";
    targetPkgs = pkgs:
      (with pkgs; [ neovim macchina which lolcat zsh timer ]);
    runScript = "/usr/bin/nvim";
  };
}
