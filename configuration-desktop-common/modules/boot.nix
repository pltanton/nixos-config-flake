{ pkgs, ... }: {
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi = { canTouchEfiVariables = true; };
    };

    initrd.systemd.enable = true;

    kernelParams = [ "quiet" ];

    plymouth.enable = true;
  };
}
