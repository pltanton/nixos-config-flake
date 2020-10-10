{ pkgs, ... }: {
  xsession = {
    enable = false;
    preferStatusNotifierItems = true;
    pointerCursor = {
      package = pkgs.paper-icon-theme;
      name = "Paper";
      size = 16;
    };


    windowManager.awesome = { enable = false; };
    # windowManager.command = "startxfce4";
    windowManager.xmonad = {
      enable = false;
      extraPackages = haskellPackages:
        with haskellPackages; [
          xmonad-extras
          xmonad-contrib
          haskellPackages.taffybar
        ];
    };
    importedVariables =
      [ "GDK_PIXBUF_ICON_LOADER" "GDK_PIXBUF_MODULE_FILE" "PATH" ];

    initExtra = ''
      ${pkgs.autorandr}/bin/autorandr -c &
      ${pkgs.xbanish}/bin/xbanish &
      ${pkgs.clipit}/bin/clipit &
      ${pkgs.lightlocker}/bin/light-locker &
      ${pkgs.haskellPackages.greenclip}/bin/greenclip daemon &
    '';
  };
}
