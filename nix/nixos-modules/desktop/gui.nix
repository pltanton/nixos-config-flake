_: {
  xdg.icons.enable = true;

  services = {
    xserver.xkb = {
      layout = "us,us";
      variant = "dvorak,";
      options = "eurosign:e,grp:win_space_toggle";
    };

    xserver = {
      enable = false;
      displayManager.gdm.enable = false;
      desktopManager.gnome.enable = false;
    };

    libinput = {
      enable = true;
      touchpad = {tapping = true;};
    };
  };

  environment.pathsToLink = ["/share/xdg-desktop-portal" "/share/applications"];
}
