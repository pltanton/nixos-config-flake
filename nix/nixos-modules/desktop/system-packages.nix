{
  config,
  pkgs,
  ...
}: {
  programs.fish.enable = true;
  programs.adb.enable = true;

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
  ];
}
