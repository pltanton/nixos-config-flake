{ config, lib, pkgs, inputs, ... }:

let
  nfsDeviceDefaults =
    "x-systemd.mount-timeout=10,x-systemd.idle-timeout=1min,nofail,_netdev,users,rw,noauto";
in {
  imports = [ inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-9th-gen ];

  hardware.steam-hardware.enable = false;
  hardware.pulseaudio.support32Bit = true;

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [ vaapiIntel intel-media-driver ];
    driSupport32Bit = true;
  };
  # environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";

  # boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.kernelPackages = pkgs.linuxPackages;
  boot.kernelPackages = pkgs.linuxPackages_zen;

  hardware.trackpoint.enable = true;
  hardware.trackpoint.emulateWheel = config.hardware.trackpoint.enable;

  services.xserver.videoDrivers = [ "intel" ];

  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  boot.kernel.sysctl = { };
  boot.kernelParams = [ ];
  # boot.kernelModules = [ "v4l2loopback" "i2c-dev" "iwlwifi" ];
  boot.kernelModules = [ "i2c-dev" "iwlwifi" ];

  fileSystems."/mnt/hass" = {
    device = "10.100.0.1:/var/lib/hass";
    # device = ":/var/lib/hass";
    fsType = "nfs";
    options = [ nfsDeviceDefaults ];
  };

  fileSystems."/mnt/home-nfs-archive" = {
    device = "10.100.0.1:/media/archive/archive";
    fsType = "nfs";
    options = [ nfsDeviceDefaults ];
  };

  fileSystems."/mnt/home-nfs-public" = {
    device = "10.100.0.1:/media/store/media";
    fsType = "nfs";
    options = [ nfsDeviceDefaults ];
  };

  fileSystems."/mnt/windows" = {
    device = "/dev/nvme0n1p4";
    fsType = "ntfs";
    options = [ "rw" ];
  };
}
