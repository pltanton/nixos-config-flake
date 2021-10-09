{ pkgs, ... }: {
  services.fwupd.enable = true;
  services.fprintd.enable = true;
}
