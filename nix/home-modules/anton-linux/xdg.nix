_: {
  xdg.enable = true;
  xdg.configFile."mimeapps.list".force = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications = let
      # browser = "org.qutebrowser.qutebrowser.desktop";
      # browser = "firefox.desktop";
      browser = "autobrowser.desktop";
      imageViewer = "org.gnome.eog.desktop";
    in {
      "text/html" = browser;
      "x-scheme-handler/http" = browser;
      "x-scheme-handler/https" = browser;
      "x-scheme-handler/about" = browser;
      "x-scheme-handler/unknown" = browser;

      "image/bmp" = imageViewer;
      "image/gif" = imageViewer;
      "image/jpeg" = imageViewer;
      "image/jpg" = imageViewer;
      "image/pjpeg" = imageViewer;
      "image/png" = imageViewer;
      "image/tiff" = imageViewer;
      "image/webp" = imageViewer;
      "image/x-bmp" = imageViewer;
      "image/x-gray" = imageViewer;
      "image/x-icb" = imageViewer;
      "image/x-ico" = imageViewer;
      "image/x-png" = imageViewer;
      "image/x-portable-anymap" = imageViewer;
      "image/x-portable-bitmap" = imageViewer;
      "image/x-portable-graymap" = imageViewer;
      "image/x-portable-pixmap" = imageViewer;
      "image/x-xbitmap" = imageViewer;
      "image/x-xpixmap" = imageViewer;
      "image/x-pcx" = imageViewer;
      "image/svg+xml" = imageViewer;
      "image/svg+xml-compressed" = imageViewer;
      "image/vnd.wap.wbmp" = imageViewer;
      "image/x-icns" = imageViewer;

      "application/pdf" = "org.gnome.Evince.desktop";

      "x-scheme-handler/tg;application/x-xdg-protocol-tg" = "org.telegram.desktop.desktop";

      "text/*" = ["zed.desktop" "codium.desktop"];
      "inode/directory" = "org.gnome.Nautilus.desktop";
    };
  };
}
