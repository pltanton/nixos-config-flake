{ pkgs, config, ... }: {
  services.swayosd = {
    enable = true;
    maxVolume = 120;
  };
}
