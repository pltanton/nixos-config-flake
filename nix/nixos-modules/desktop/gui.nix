_: {
  xdg.icons.enable = true;

  services = {
    xserver.xkb = {
      layout = "us,us";
      variant = "dvorak,";
      options = "eurosign:e,grp:win_space_toggle";
    };

    libinput = {
      enable = true;
      touchpad = {tapping = true;};
    };
  };

  environment.pathsToLink = ["/share/xdg-desktop-portal" "/share/applications"];
}
