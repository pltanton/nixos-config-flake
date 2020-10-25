{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.common-pc-laptop-acpi_call
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-cpu-intel
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.trackpoint.enable = true;
  hardware.trackpoint.emulateWheel = config.hardware.trackpoint.enable;

  hardware.opengl.enable = true;

  services.xserver.videoDrivers = [ "intel" ];

  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=2 video_nr=5,6 card_label="wfrecorder","fakecam" exclusive_caps=1
  '';
  boot.kernelModules = [ "v4l2loopback" ];

  fileSystems."/mnt/hass" = {
    device = "10.100.0.1:/var/lib/hass";
    fsType = "nfs";
    options = ["user,rw,defaults,noauto"];
  };

  fileSystems."/mnt/home-nfs-archive" = {
    device = "10.100.0.1:/media/archive/archive";
    fsType = "nfs";
    options = ["x-systemd.automount,rw,defaults,noauto"];
  };

  fileSystems."/mnt/home-nfs-public" = {
    device = "10.100.0.1:/media/store/media";
    fsType = "nfs";
    options = ["x-systemd.automount,rw,defaults,noauto"];
  };
}
