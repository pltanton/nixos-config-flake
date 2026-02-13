_: {
  boot = {
    kernelParams = [
      "pcie_aspm=force"
      "i915.enable_psr=1"
      "i915.enable_fbc=1"
      "i915.enable_rc6=1"
    ];

    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi = {canTouchEfiVariables = true;};
    };

    initrd.systemd.enable = true;
    plymouth.enable = true;
  };
}
