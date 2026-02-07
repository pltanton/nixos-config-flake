{
  config,
  pkgs,
  inputs,
  ...
}: let
  nfsDeviceDefaults = "x-systemd.mount-timeout=10,x-systemd.idle-timeout=1min,nofail,_netdev,user,users,rw,noauto";
  hp-wmi-module = pkgs.callPackage ./hp-wmi-module.nix {
    kernel = config.boot.kernelPackages.kernel;
  };
in {
  imports = [
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];
  hardware.enableAllFirmware = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.verbose = false;
    kernelParams = [
      "nvidia.NVreg_TemporaryFilePath=/var/tmp"

      "quiet"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"

      # "acpi_enforce_resources=lax"
      # "acpi_osi=Linux"
      # "acpi_backlight=vendor"
      # "pstate.default_governor=performance"
    ];
    blacklistedKernelModules = ["i2c_designware_pci" "i2c_designware_platform"];
    consoleLogLevel = 3;

    extraModulePackages = [
      (hp-wmi-module.overrideAttrs (_: {
        patches = [./hp-wmi-omen-14.patch];
      }))
    ];

    loader.systemd-boot.consoleMode = "max";
  };

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
