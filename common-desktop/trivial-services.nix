{ pkgs, ... }: {
  programs = {
    sway.enable = true;
    waybar.enable = false;
  };

  services = {
    autorandr.enable = true;

    upower.enable = true;
  };
}
