{ pkgs, lib, config, ... }: {
  gtk.iconCache.enable = true;
  xdg.icons.enable = true;

  services.gnome.chrome-gnome-shell.enable = true;

  # environment.systemPackages = with pkgs; [ gnomeExtensions.material-shell ];

  services.xserver = {
    enable = false;

    wacom.enable = true;

    layout = "us,us";
    xkbVariant = "dvorak,";
    xkbOptions = "eurosign:e,grp:caps_toggle,grp:alt_space_toggle";

    libinput = {
      enable = true;
      touchpad = { tapping = true; };
    };

    displayManager.sddm.enable = false;

    # desktopManager.session = [{
    #   name = "home-manager";
    #   start = ''
    #     ${pkgs.runtimeShell} $HOME/.xsession &
    #     waitPID=$!
    #   '';
    # }];
  };

  # programs.sway.enable = false;
  xdg.portal = lib.mkIf (!config.services.xserver.desktopManager.gnome.enable) {
    enable = true;
    # gtkUsePortal = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-wlr xdg-desktop-portal-gtk ];
  };

  # programs.dconf.enable =
  #   lib.mkIf (!config.services.xserver.desktopManager.gnome.enable) true;
}
