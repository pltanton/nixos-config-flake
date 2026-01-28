{config, ...}: let
  # wallpaper = ../../../../backgrounds/yosemite.png;
  wallpaper = toString config.backgrounds."metheora-mocha.jpg";
in {
  services.hyprpaper = {
    inherit (config.wayland.windowManager.hyprland) enable;

    settings = {
      ipc = false;
      preload = [
        "${wallpaper}"
      ];
      wallpaper = [
        {
          monitor = "";
          path = wallpaper;
          fit_mode = "cover";
        }
      ];
    };
  };
}
