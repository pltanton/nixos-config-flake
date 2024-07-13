{config, ...}: let
  # wallpaper = ../../../../backgrounds/yosemite.png;
  wallpaper = config.stylix.image;
in {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = false;
      wallpaper = [
        ",${wallpaper}"
      ];
    };
  };
}
