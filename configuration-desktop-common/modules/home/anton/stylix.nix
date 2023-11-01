{ pkgs, inputs, ... }: {

  stylix = {
    targets.swaylock.enable = false;
    targets.rofi.enable = false;
    targets.gtk.enable = false;
    targets.gnome.enable = false;
    targets.waybar.enable = false;
    targets.avizo.enable = false;
    targets.vscode.enable = false;
    targets.hyprland.enable = false;
  };
}
