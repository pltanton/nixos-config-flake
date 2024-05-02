{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  # gtk.iconCache.eable = true;
  xdg.icons.enable = true;

  # Gnome system packages
  services.gnome.gnome-browser-connector.enable =
    config.services.xserver.desktopManager.gnome.enable;
  environment.systemPackages = with pkgs;
    lib.mkIf (config.services.xserver.desktopManager.gnome.enable) [
      gnome.gnome-tweaks

      gnomeExtensions.extensions-sync
      gnomeExtensions.appindicator
      gnomeExtensions.user-themes-x
      gnomeExtensions.windownavigator
      # gnomeExtensions.tiling-assistant
      # gnomeExtensions.forge
      gnomeExtensions.pop-shell
    ];

  # environment.systemPackages = with pkgs; [ gnomeExtensions.material-shell ];

  services.xserver = {
    enable = false;

    displayManager.gdm.enable = false;
    displayManager.gdm.wayland = false;
    desktopManager.gnome.enable = false;

    wacom.enable = true;

    xkb.layout = "us,us";
    xkb.variant = "dvorak,";
    xkb.options = "eurosign:e,grp:win_space_toggle";
  };

  services.libinput = {
    enable = true;
    touchpad = {tapping = true;};
  };
}
