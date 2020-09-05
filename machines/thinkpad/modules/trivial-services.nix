{ pkgs, ... }: {
  services = {
    autorandr.enable = true;

    upower.enable = true;
  };
}
