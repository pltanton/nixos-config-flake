{config, ...}: let
  # wallpaper = ../../../../backgrounds/yosemite.png;
  wallpaper = config.stylix.image;
in {
  services.hyprpaper = {
    enable = config.wayland.windowManager.hyprland.enable;
    settings = {
      ipc = false;
      wallpaper = [
        ",${wallpaper}"
      ];
    };
  };
}
