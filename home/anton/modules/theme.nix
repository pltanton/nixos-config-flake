{ pkgs, ... }: {
  themes.base16 = {
    enable = true;
    scheme = "onedark";
    variant = "onedark";
    extraParams = {
      fontConsoleName = "Iosevka Term";
      fontConsoleSize = "19";
      fontUIName = "Inter";
      fontUISize = "19";
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
