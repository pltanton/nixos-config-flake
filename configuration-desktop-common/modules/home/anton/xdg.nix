{ pkgs, ... }: {
  xdg.enable = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications =
      let
        # browser = "org.qutebrowser.qutebrowser.desktop";
        browser = "browser-select.desktop";
        imageViewer = "org.gnome.eog.desktop";
      in
      {
        "text/html" = browser;
        "x-scheme-handler/http" = browser;
        "x-scheme-handler/https" = browser;
        "x-scheme-handler/about" = browser;
        "image/bmp;image/gif;image/jpeg;image/jpg;image/pjpeg;image/png;image/tiff;image/webp;image/x-bmp;image/x-gray;image/x-icb;image/x-ico;image/x-png;image/x-portable-anymap;image/x-portable-bitmap;image/x-portable-graymap;image/x-portable-pixmap;image/x-xbitmap;image/x-xpixmap;image/x-pcx;image/svg+xml;image/svg+xml-compressed;image/vnd.wap.wbmp;image/x-icns;" = imageViewer;
        # "x-scheme-handler/unknown" = browser;
        "application/pdf" = "org.gnome.Evince.desktop";

        # "x-scheme-handler/mailto" = "userapp-Thunderbird-X4TET0.desktop";
        "x-scheme-handler/tg;application/x-xdg-protocol-tg" =
          "org.telegram.desktop.desktop";
        # "x-scheme-handler/zoommtng" = "Zoom.desktop";
      };
  };
}
