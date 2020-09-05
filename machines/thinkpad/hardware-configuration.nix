{ config, lib, pkgs, ... }:

{
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/dec4e19f-a16e-4a81-b82f-9c6c404c832b";
      fsType = "ext4";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/e34e0d63-cd2f-49bf-b089-587552c0cc22";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/3F54-D3D5";
      fsType = "vfat";
    };

  fileSystems."/mnt/home-nfs-archive" = {
    device = "192.168.20.3:/media/archive/archive";
    fsType = "nfs";
    options = ["rw,defaults,noauto"];
  };

  fileSystems."/mnt/home-nfs-public" = {
    device = "192.168.20.3:/media/store/media";
    fsType = "nfs";
    options = ["rw,defaults,noauto"];
  };

  #swapDevices = [ { device = "/dev/sda3"; } ];

  nix.maxJobs = lib.mkDefault 4;
  powerManagement.cpuFreqGovernor = "powersave";

  services.xserver.videoDrivers = [ "intel" ];
  services.xserver.config = pkgs.lib.mkOverride 50 (builtins.readFile ./xorg.conf);
}
