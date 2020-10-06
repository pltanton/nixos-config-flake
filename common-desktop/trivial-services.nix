{ pkgs, ... }: {
  programs = {
    sway.enable = true;
    waybar.enable = false;
  };

  services = {
    autorandr.enable = true;
    pcscd.enable = true;
    upower.enable = true;
  };
}
