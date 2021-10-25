{ config, lib, pkgs, inputs, ... }:

let
  nfsDeviceDefaults =
    "x-systemd.mount-timeout=10,x-systemd.idle-timeout=1min,nofail,_netdev,users,rw,noauto";
in {
  imports = [
    # inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-7th-gen
    inputs.nixos-hardware.nixosModules.common-pc-laptop-acpi_call
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-laptop
  ];
  hardware.pulseaudio.support32Bit = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=2 video_nr=5,6 card_label="wfrecorder","fakecam" exclusive_caps=1
  '';
  boot.kernelModules = [ "v4l2loopback" "i2c-dev" ];

  services.xserver.videoDrivers = [ "intel" ];


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
}
