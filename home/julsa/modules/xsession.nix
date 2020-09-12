{ pkgs, ... }: {
  xsession = {
    enable = true;
    preferStatusNotifierItems = true;
    pointerCursor = {
      package = pkgs.paper-icon-theme;
      name = "Paper";
      size = 16;
    };
    windowManager.command = "startxfce4";
    importedVariables = [ "GDK_PIXBUF_MODULE_FILE" "PATH" ];

    initExtra = ''
      ${pkgs.autorandr}/bin/autorandr -c &
      ${pkgs.xbanish}/bin/xbanish &
      ${pkgs.clipit}/bin/clipit &
      ${pkgs.lightlocker}/bin/light-locker &
      ${pkgs.haskellPackages.greenclip}/bin/greenclip daemon &
    '';
  };
}
