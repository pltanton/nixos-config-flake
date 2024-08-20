{pkgs, ...}: {
  services.fwupd.enable = true;
  security.polkit.enable = true;
  services.fprintd = {
    enable = true;
  };
}
