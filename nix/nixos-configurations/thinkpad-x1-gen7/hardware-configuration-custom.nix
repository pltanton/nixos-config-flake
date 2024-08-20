{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  nfsDeviceDefaults = "x-systemd.mount-timeout=10,x-systemd.idle-timeout=1min,nofail,_netdev,users,rw,noauto";
in {
  imports = [
    # inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-7th-gen
    inputs.nixos-hardware.nixosModules.common-pc-laptop-acpi_call
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-laptop
  ];

  hardware.steam-hardware.enable = false;
  hardware.pulseaudio.support32Bit = true;

  environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";

  boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.kernelPackages = pkgs.linuxPackages;
  # boot.kernelPackages = pkgs.linuxPackages_zen;

  hardware.trackpoint.enable = true;
  hardware.trackpoint.emulateWheel = config.hardware.trackpoint.enable;

  services.xserver.videoDrivers = ["intel"];

  boot.extraModulePackages = with config.boot.kernelPackages; [v4l2loopback];
  boot.kernel.sysctl = {
    "vm.dirty_writeback_centisecs" = 6000;
    "kernel.nmi_watchdog" = 0;
  };
  boot.kernelParams = [
    "intel_pstate=enable"
    "msr.allow_writes=on"
    "workqueue.power_efficient=true"
  ];
  boot.extraModprobeConfig = lib.mkMerge [
    ''
      options v4l2loopback devices=2 video_nr=5,6 card_label="wfrecorder","fakecam" exclusive_caps=1''
    "options iwlwifi power_save=1 uapsd_disable=0"
    "options iwlmvm power_scheme=3"
    "options iwldvm force_cam=0"
    "options i915 enable_guc=2"
    "options i915 enable_fbc=1"
    "options i915 enable_psr=1"
    "options i915 enable_rc6=1"
  ];
  boot.kernelModules = ["v4l2loopback" "i2c-dev" "iwlwifi"];

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

  # powerManagement.scsiLinkPolicy = "min_power";

  # boot.initrd.availableKernelModules = [ "thinkpad_acpi" ];
}
