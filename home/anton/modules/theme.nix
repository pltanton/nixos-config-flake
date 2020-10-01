{ pkgs, ... }: {
  themes.base16 = {
    enable = true;
    scheme = "onedark";
    variant = "onedark";
    extraParams = {
      fontConsoleName = "Iosevka Term";
      fontConsoleSize = "22";
      fontUIName = "Inter";
      fontUISize = "22";
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
