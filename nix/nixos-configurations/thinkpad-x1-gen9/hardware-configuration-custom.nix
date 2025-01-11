{
  config,
  pkgs,
  inputs,
  ...
}: let
  nfsDeviceDefaults = "x-systemd.mount-timeout=10,x-systemd.idle-timeout=1min,nofail,_netdev,user,users,rw,noauto";
in {
  imports = [inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-9th-gen];

  hardware.pulseaudio.support32Bit = true;

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_12;

  hardware.trackpoint.enable = true;
  hardware.trackpoint.emulateWheel = config.hardware.trackpoint.enable;

  services.xserver.videoDrivers = ["intel"];

  boot.extraModulePackages = with config.boot.kernelPackages; [v4l2loopback];
  boot.kernel.sysctl = {};
  boot.kernelParams = ["i915.enable_psr=1"];
  # boot.kernelModules = [ "v4l2loopback" "i2c-dev" "iwlwifi" ];
  boot.kernelModules = ["i2c-dev" "iwlwifi"];

  fileSystems."/mnt/hass" = {
    device = "10.100.0.1:/var/lib/hass";
    # device = ":/var/lib/hass";
    fsType = "nfs";
    options = [nfsDeviceDefaults];
  };

  fileSystems."/mnt/home-nfs-archive" = {
    device = "10.100.0.1:/media/archive/archive";
    fsType = "nfs";
    options = [nfsDeviceDefaults];
  };

  fileSystems."/mnt/home-nfs-public" = {
    device = "10.100.0.1:/media/store/media";
    fsType = "nfs";
    options = [nfsDeviceDefaults];
  };

  fileSystems."/mnt/windows" = {
    device = "/dev/nvme0n1p4";
    fsType = "ntfs";
    options = ["rw"];
  };
}
