pkgs: {
  dmenu = (pkgs.dmenu.overrideAttrs { src = ./src; }).override {
    patches = [

      # -c -l 10
      (pkgs.fetchpatch {
        url =
          "https://tools.suckless.org/dmenu/patches/center/dmenu-center-5.2.diff";
        hash = "sha256-g7ow7GVUsisR2kQ4dANRx/pJGU8fiG4fR08ZkbUFD5o=";
      })

      (pkgs.fetchpatch {
        url =
          "https://tools.suckless.org/dmenu/patches/desktoponly/dmenu-desktoponly-20230805-7ab0cb5.diff";
        hash = "sha256-Z4ASSL+bOfWArojvl0zlzB2pXNM+PQjb+V5HHoN1vds=";
      })

      # (pkgs.fetchpatch {
      #   url =
      #     "https://tools.suckless.org/dmenu/patches/vi-mode/dmenu-vi_mode-20230416-0fe460d.diff";
      #   hash = "sha256-axl94a1qVAiCUcfZnmjuzKRDhH//jCNHj/RPZ5xdo4Y=";
      # })

    ];
  };
}
