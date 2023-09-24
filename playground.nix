{pkgs}:
with pkgs;
  mkShell {
    name = "playground";
    packages = [
      pfetch
      macchina
      freshfetch
      cpufetch
      neofetch
      screenfetch
      nix-info
    ];
  }
