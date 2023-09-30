pkgs: {
  noevim-fhs = pkgs.buildFHSEnv {
    name = "noevim";
    targetPkgs = pkgs:
      (with pkgs; [ neovim neofetch which bat zsh fish timer ]);
    runScript = "/usr/bin/nvim";
  };
}
