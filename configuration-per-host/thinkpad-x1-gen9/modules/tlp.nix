{ pkgs, config, ... }: {
  services.tlp = {
    enable = !config.services.xserver.desktopManager.gnome.enable;
    settings = {
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      #     CPU_SCALING_GOVERNOR_ON_AC = "performance";
      #     CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      #     CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      #     CPU_HWP_ON_BAT = "power";
      #     CPU_HWP_DYN_BOOST_ON_BAT = 0;
      #     CPU_BOOST_ON_AC = 1;
      #     CPU_BOOST_ON_BAT = 0;
      #     CPU_SCALING_MAX_FREQ_ON_BAT = 1200000;
      #     CPU_SCALING_MAX_FREQ_ON_AC = 2700000;

      #     ENERGY_PERF_POLICY_ON_BAT = "power";
      #     START_CHARGE_THRESH_BAT0 = 60;
      #     STOP_CHARGE_THRESH_BAT0 = 80;
      #     RUNTIME_PM_ON_BAT = "auto";

      #     INTEL_GPU_MAX_FREQ_ON_AC = 1150;
      #     INTEL_GPU_MAX_FREQ_ON_BAT = 800;
      #     INTEL_GPU_MIN_FREQ_ON_AC = 300;
      #     INTEL_GPU_MIN_FREQ_ON_BAT = 300;
      #     INTEL_GPU_BOOST_FREQ_ON_AC = 1150;
      #     INTEL_GPU_BOOST_FREQ_ON_BAT = 900;

      #     SATA_LINK_POWEN_ON_BAT = "min_power";
    };
  };
}
