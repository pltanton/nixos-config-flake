{
  config,
  pkgs,
  inputs,
  ...
}: let
  nfsDeviceDefaults = "x-systemd.mount-timeout=10,x-systemd.idle-timeout=1min,nofail,_netdev,user,users,rw,noauto";
in {
  imports = [
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];
	boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.enableAllFirmware = true;

  services.hardware.openrgb.enable = true;

  fileSystems = {
    "/mnt/hass" = {
      device = "10.100.0.1:/var/lib/hass";
      # device = ":/var/lib/hass";
      fsType = "nfs";
      options = [nfsDeviceDefaults];
    };

    "/mnt/home-nfs-archive" = {
      device = "10.100.0.1:/media/archive/archive";
      fsType = "nfs";
      options = [nfsDeviceDefaults];
    };

    "/mnt/home-nfs-public" = {
      device = "10.100.0.1:/media/store/media";
      fsType = "nfs";
      options = [nfsDeviceDefaults];
    };

    # "/mnt/windows" = {
    #   device = "/dev/nvme0n1p3";
    #   fsType = "ntfs";
    #   options = ["rw"];
    # };
  };
}
