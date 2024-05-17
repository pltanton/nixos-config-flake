{pkgs, ...}: {
  services.fwupd.enable = true;
  security.polkit.enable = true;
  services.fprintd = {
    enable = true;
    # tod.enable = false;
    # tod.driver = pkgs.libfprint-2-tod1-vfs0090;
  };
}
