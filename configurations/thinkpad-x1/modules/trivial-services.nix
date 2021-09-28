{ pkgs, ... }: {
  services = {
    autorandr.enable = false;
    pcscd.enable = false;
    upower.enable = true;
  };
}
