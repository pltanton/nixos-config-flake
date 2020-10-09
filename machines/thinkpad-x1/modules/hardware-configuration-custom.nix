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
  boot.kernelModules = [ "v4l2loopback" ];
}
