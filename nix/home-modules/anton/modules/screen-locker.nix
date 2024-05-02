{pkgs, ...}: {
  services.screen-locker = {
    enable = false;
    lockCmd = "${pkgs.lightlocker}/bin/light-locker-command -l";
    inactiveInterval = 15;
  };
}
