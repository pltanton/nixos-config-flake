{ pkgs, ... }: {
  xdg.enable = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications = let
      # browser = "org.qutebrowser.qutebrowser.desktop";
      browser = "browser-select.desktop";
    in {
      "text/html" = browser;
      "x-scheme-handler/http" = browser;
      "x-scheme-handler/https" = browser;
      "x-scheme-handler/about" = browser;
      "x-scheme-handler/unknown" = browser;

      # "x-scheme-handler/mailto" = "userapp-Thunderbird-X4TET0.desktop";
      "x-scheme-handler/tg" = "telegramdesktop.desktop";
      "x-scheme-handler/zoommtng" = "Zoom.desktop";
    };
  };
}