{ pkgs, inputs, ... }: {

  stylix = {
    targets.swaylock.enable = false;
    targets.rofi.enable = false;
    targets.gtk.enable = false;
    targets.waybar.enable = false;
  };
}
