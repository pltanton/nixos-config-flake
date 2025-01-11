{...}: {
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  users.users.anton.extraGroups = ["libvirtd"];

  boot.kernelModules = ["kvm-intel"];
}
