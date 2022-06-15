{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    acpi
    busybox

    exfat
    ntfs3g
    nfs-utils
    suidChroot

    sshfs
    keyutils

    home-manager
    super
  ];
}
