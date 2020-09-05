{ pkgs, ... }: {
  themes.base16 = {
    enable = true;
    scheme = "gruvbox";
    variant = "gruvbox-dark-hard";
    extraParams = {
      fontConsoleName = "Iosevka Term";
      fontConsoleSize = "13";
    };
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.qogir-theme;
      name = "Qogir-dark";
    };
    iconTheme = {
      package = pkgs.qogir-icon-theme;
      name = "Qogir-dark";
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
  };
}
