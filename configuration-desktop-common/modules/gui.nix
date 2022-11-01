{ pkgs, lib, config, ... }: {
  gtk.iconCache.enable = true;
  xdg.icons.enable = true;

  # Gnome system packages
  services.gnome.chrome-gnome-shell.enable =
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
    displayManager.gdm.enable = false;
    displayManager.gdm.wayland = false;
    desktopManager.gnome.enable = false;

    wacom.enable = true;

    layout = "us,us";
    xkbVariant = "dvorak,";
    xkbOptions = "eurosign:e,grp:caps_toggle,grp:alt_space_toggle";

    libinput = {
      enable = true;
      touchpad = { tapping = true; };
    };

    desktopManager.session = [{
      name = "hyprland";
      start = ''
        ${pkgs.runtimeShell} $HOME/.xsession &
        waitPID=$!
      '';
    }];
  };

  # programs.sway.enable = false;
  xdg.portal = lib.mkIf (!config.services.xserver.desktopManager.gnome.enable) {
    enable = true;
    wlr.enable = false;
    extraPortals = with pkgs; [ xdg-desktop-portal-wlr xdg-desktop-portal-gtk ];
  };

  programs.dconf.enable =
    lib.mkIf (!config.services.xserver.desktopManager.gnome.enable) true;
}
