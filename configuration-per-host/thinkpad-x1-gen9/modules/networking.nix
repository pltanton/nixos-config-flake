{ config, lib, pkgs, ... }:

{
  networking.networkmanager.enableFccUnlock = true;
  systemd.services.ModemManager.enable = true;
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];
}
