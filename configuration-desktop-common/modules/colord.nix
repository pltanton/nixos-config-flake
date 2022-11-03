{ config, lib, pkgs, ... }:

{
  services.colord.enable = true;
  environment.systemPackages =
    lib.mkIf config.services.colord.enable [ pkgs.colord-gtk ];
}
