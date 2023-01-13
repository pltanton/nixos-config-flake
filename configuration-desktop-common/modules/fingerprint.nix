{ pkgs, ... }: {
  services.fwupd.enable = true;
  security.polkit.enable = true;
  services.fprintd = {
    enable = true;
    tod.enable = true;
    tod.driver = pkgs.libfprint-2-tod1-vfs0090;
  };
}
