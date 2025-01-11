{...}: {
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi = {canTouchEfiVariables = true;};
    };

    initrd.systemd.enable = true;

    kernelParams = ["quiet"];

    plymouth.enable = true;
  };
}
