{ config, lib, pkgs, inputs, ... }:

{
  imports = [ inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-7th-gen ];
  services.xserver.videoDrivers = [ "intel" ];
}
