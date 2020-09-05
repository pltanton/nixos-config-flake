{ pkgs, ... }: {
  services.screen-locker = {
    enable = true;
    lockCmd = "${pkgs.lightlocker}/bin/light-locker-command -l";
    inactiveInterval = 15;
  };
}
