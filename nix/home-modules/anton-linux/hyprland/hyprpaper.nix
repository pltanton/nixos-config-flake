{config, ...}: let
  # wallpaper = ../../../../backgrounds/yosemite.png;
  wallpaper = config.backgrounds."metheora-mocha.jpg";
in {
  services.hyprpaper = {
    inherit (config.wayland.windowManager.hyprland) enable;

    settings = {
      ipc = false;
      splash = false;
      preload = [
        "${wallpaper}"
      ];
      wallpaper = [
        {
          monitor = "";
          path = toString wallpaper;
          fit_mode = "cover";
        }
      ];
    };
  };
}
