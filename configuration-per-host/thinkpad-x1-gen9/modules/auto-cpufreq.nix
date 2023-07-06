{ pkgs, config, ... }: {
  services.auto-cpufreq = {
    # enable = !config.services.xserver.desktopManager.gnome.enable
    # && !config.services.xserver.desktopManager.plasma5.enable;
    enable = false;

    settings = {
      charger = {
        scaling_min_cpufreq = 800000;
        turbo = "always";
      };
    };
  };
}
