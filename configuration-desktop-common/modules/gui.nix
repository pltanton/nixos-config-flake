{ pkgs, lib, config, inputs, ... }: {
  gtk.iconCache.enable = true;
  xdg.icons.enable = true;

  # Gnome system packages
  services.gnome.gnome-browser-connector.enable =
    config.services.xserver.desktopManager.gnome.enable;
  environment.systemPackages = with pkgs;
    lib.mkIf (config.services.xserver.desktopManager.gnome.enable) [
      gnome.gnome-tweaks
      gnomeExtensions.pano
      gnomeExtensions.user-themes-x
      gnomeExtensions.windownavigator
      gnomeExtensions.tiling-assistant
      gnomeExtensions.pop-shell
    ];

  # environment.systemPackages = with pkgs; [ gnomeExtensions.material-shell ];

  services.xserver = {
    enable = false;

    displayManager.lightdm = { enable = false; };
    displayManager.startx = { enable = true; };

    displayManager.gdm.enable = false;
    displayManager.gdm.wayland = false;
    desktopManager.gnome.enable = false;

    displayManager.sddm.enable = false;
    desktopManager.plasma5.enable = false;

    wacom.enable = true;

    layout = "us,us";
    xkbVariant = "dvorak,";
    xkbOptions = "eurosign:e,grp:caps_toggle,grp:alt_space_toggle";

    libinput = {
      enable = true;
      touchpad = { tapping = true; };
    };
  };

  # programs.sway.enable = false;
  # xdg.portal
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # programs.dconf.enable =
  #   lib.mkIf (!config.services.xserver.desktopManager.gnome.enable) true;
}
