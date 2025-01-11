# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{pkgs, ...}: {
  imports =
    builtins.map (name: ./modules + "/${name}")
    (builtins.attrNames (builtins.readDir ./modules));

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda"; # or "nodev" for efi only

  environment.systemPackages = [pkgs.vim pkgs.pgloader];

  networking.hostName = "sprintbox";
  networking.interfaces.ens3.ipv4.addresses = [
    {
      address = "141.8.195.83";
      prefixLength = 24;
    }
  ];
  networking.defaultGateway = "141.8.195.1";
  networking.nameservers = ["141.8.194.254" "141.8.197.254"];
  networking.useDHCP = false;
  networking.interfaces.ens3.useDHCP = false;

  time.timeZone = "Europe/Moscow";

  security.acme.defaults.email = "plotnikovanton@gmail.com";
  security.acme.acceptTerms = true;
}
