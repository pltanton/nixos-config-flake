{ config, lib, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "intel" ];
}
