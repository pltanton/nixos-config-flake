{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  xdg.icons.enable = true;

  services.xserver = {
    xkb.layout = "us,us";
    xkb.variant = "dvorak,";
    xkb.options = "eurosign:e,grp:win_space_toggle";
  };

  services.libinput = {
    enable = true;
    touchpad = {tapping = true;};
  };

  environment.pathsToLink = ["/share/xdg-desktop-portal" "/share/applications"];
}
