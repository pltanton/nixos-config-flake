{ pkgs, ... }: {
  virtualisation.libvirtd.enable = true;
  boot.kernelModules = [ "kvm-intel" ];
}
