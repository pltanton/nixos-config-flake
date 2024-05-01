{ config, pkgs, ... }: {
  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", GROUP="ddc", MODE="0660"
  '';
  users.groups.ddc.members = [ "anton" ];
}
