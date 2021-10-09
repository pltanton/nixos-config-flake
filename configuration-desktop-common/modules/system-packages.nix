{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    acpi

    exfat
    ntfs3g
    nfs-utils
    suidChroot

    sshfs

    keyutils

    hicolor-icon-theme
    papirus-icon-theme

    home-manager
    super
  ];
}
