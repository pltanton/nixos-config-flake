{config, ...}: {
  services.power-profiles-daemon.enable = false;

  services.tlp = {
    enable = true;
    settings = {
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      START_CHARGE_THRESH_BAT0 = 70;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };
}
