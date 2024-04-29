{ pkgs, ... }: {
  virtualisation.libvirtd.enable = false;
  programs.virt-manager.enable = false;
  users.users.anton.extraGroups = [ "libvirtd" ];

  boot.kernelModules = [ "kvm-intel" ];
}
