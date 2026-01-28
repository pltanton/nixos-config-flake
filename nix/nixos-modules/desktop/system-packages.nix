{pkgs, ...}: {
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    acpi
    android-tools
    busybox

    exfat
    ntfs3g
    nfs-utils

    sshfs
    keyutils

    home-manager
  ];
}
