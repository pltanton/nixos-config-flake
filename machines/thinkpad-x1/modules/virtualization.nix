{ pkgs, ... }: {
  virtualisation.virtualbox.host.enable = true;
  virtualisation.libvirtd.enable = true;
  boot.kernelModules = [ "kvm-intel" ];
}
