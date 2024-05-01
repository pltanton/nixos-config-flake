{ pkgs, ... }:
{
  programs.hyprlock = {
    enable = true;

    general = {
      grace = 5;
    };

    backgrounds = [
      {
        path = "screenshot";
        blur_passes = 2;
        blur_size = 7;
        noise = 0.0117;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      }
    ];

    labels = [
      {
        text = "$TIME";
        font_size = 80;
        font_family = "Inter";
      }
    ];

    input-fields = [
      {
      }
    ];
  };
}
