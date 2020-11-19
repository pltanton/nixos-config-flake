{ pkgs, ... }: {
  services.pipewire.enable = true;
  gtk.iconCache.enable = true;
  xdg.icons.enable = true;

  services.xserver = {
    enable = false;

    wacom.enable = true;

    layout = "us,ru";
    #xkbVariant = "dvorak,";
    xkbOptions = "eurosign:e,grp:caps_toggle,grp:alt_space_toggle";

    libinput.enable = true;

    displayManager.gdm = {
      enable = false;
    };
    desktopManager.gnome3 = {
      enable = true;
    };
  #   desktopManager.xterm.enable = true;

  #   config = pkgs.lib.mkOverride 50 ''
  #     Section "Device"
  #         Identifier  "Intel Graphics"
  #         Driver      "intel"
  #         Option      "AccelMethod" "sna"
  #         Option      "TearFree" "true"
  #     EndSection

  #     Section "Device"
  #         Identifier  "Intel Graphics"
  #         Driver      "intel"
  #         Option      "Backlight"  "intel_backlight"
  #     EndSection
  #   '';
  };

  programs.sway.enable = false;
  # xdg.portal.enable = true;
  # xdg.portal.gtkUsePortal = true;
  # xdg.portal.extraPortals = with pkgs;
  #   [ xdg-desktop-portal-wlr xdg-desktop-portal-gtk ];
  #
  programs.dconf.enable = true;
  environment.systemPackages = [ pkgs.gnome3.adwaita-icon-theme pkgs.qogir-icon-theme ];
}
