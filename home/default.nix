{
  config,
  pkgs,
  unstable,
  ...
}: {
  imports = [
    ./programs
  ];

  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "laken";
  home.homeDirectory = "/home/laken";
  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.packages = [
    pkgs.alejandra
    pkgs.wormhole-rs
    pkgs.magic-wormhole
  ];

  programs.home-manager.enable = true; # Let Home Manager install and manage itself.
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/laken/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
}
