{
  config,
  lib,
  ...
}: let
  inherit (config.lib.stylix) colors;
in {
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        grace = 5;
        hide_cursor = true;
      };

      auth = {
        "fingerprint:enabled" = true;
      };

      background = lib.mkForce [
        {
          monitor = "";
          # path = "screenshot";
          path = "${config.stylix.image}";
          blur_passes = 3;
          contrast = 0.5;
          brightness = 0.3;
          # vibrancy = 0.8916;
          vibrancy_darkness = 0.5;
        }
      ];

      shape = [
      ];

      image = [
        {
          monitor = "";
          path = "${../profile-pic.jpg}";
          border_color = "0xffdddddd";
          border_size = 0;
          size = 120;
          rounding = -1;
          rotate = 0;
          reload_time = -1;
          reload_cmd = "";
          position = "0, -20";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "250, 60";
          outline_thickness = 2;
          dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true;
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(${colors.base00}33)";
          font_color = "rgb(${colors.base05})";
          fade_on_empty = false;
          font_family = "Inter";
          placeholder_text = ''<i><span foreground="##ffffff99">Enter Pass</span></i>'';
          hide_input = false;
          position = "0, -225";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        # Time
        {
          monitor = "";
          text = ''cmd[update:1000] echo "<span>$(date +"%H:%M")</span>"'';
          color = "rgba(${colors.base05}b2)";
          font_size = 130;
          font_family = "Inter";
          position = "0, 240";
          halign = "center";
          valign = "center";
        }

        # Day-Month-Date
        {
          monitor = "";
          text = ''cmd[update:1000] echo -e "$(date +"%A, %B %d")"'';
          color = "rgba(${colors.base05}b2)";
          font_size = 30;
          font_family = "Inter";
          position = "0, 105";
          halign = "center";
          valign = "center";
        }

        # User
        {
          monitor = "";
          text = "Hi, $USER";
          color = "rgba(${colors.base05}b2)";
          font_size = 25;
          font_family = "Inter";
          position = "0, -130";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
