{
  config,
  pkgs,
  lib,
  ...
}: {
  #imports = [ (nixpkgs + "/nixos/modules/profiles/qemu-guest.nix") ];

  boot = {
    initrd.postDeviceCommands = ''
      # Set the system time from the hardware clock to work around a
      # bug in qemu-kvm > 1.5.2 (where the VM clock is initialised
      # to the *boot time* of the host).
      hwclock -s
    '';

    initrd.kernelModules = ["virtio_balloon" "virtio_console" "virtio_rng"];
    initrd.availableKernelModules = [
      "virtio_net"
      "virtio_pci"
      "virtio_mmio"
      "virtio_blk"
      "virtio_scsi"
      "9p"
      "9pnet_virtio"

      "ata_piix"
      "uhci_hcd"
      "virtio_pci"
      "sd_mod"
      "sr_mod"
    ];
    loader.grub.enable = true;
    loader.grub.device = "/dev/sda";
    kernel.sysctl."net.ipv4.ip_forward" = 1;
  };

  fileSystems."/" = {
    label = "osroot";
    fsType = "ext4";
  };
}
