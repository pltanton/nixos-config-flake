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

  # services.displayManager.ly = {
  #   enable = true;
  #   settings = {
  #     default_input = "password";
  #     session_log = "ly-session.log";
  #   };
  # };
}
