{
  config,
  pkgs,
  unstable,
  user,
  ...
}: {
  imports = [
    ./programs
    ./shells
  ];

  home.username = "${user}";
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    alejandra
    wormhole-rs
    magic-wormhole
  ];
  # ++ [
  #   unstable.hello
  # ];

  programs.home-manager.enable = true;
}
