{config, lib, ...}: {
  programs.hyprlock = {
    enable = true;

    settings = with config.lib.stylix.colors; {
      general = {
        grace = 5;
        hide_cursor = true;
      };

      background = lib.mkForce [
        {
          path = "screenshot";
          blur_passes = 5;
          blur_size = 5;
          noise = 0.0117;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];

      # label = [
      #   {
      #     monitor = "";
      #     position = "0, 300";
      #     halign = "center";
      #     valign = "center";

      #     text = "$TIME";
      #     font_size = 150;
      #     font_family = "Inter";
      #     color = "rgb(${base07-hex})";
      #   }
      # ];

      # input-field = [
      #   {
      #     monitor = "";
      #     position = "0, 0";
      #     halign = "center";
      #     valign = "center";

      #     size = "400, 100";
      #     font_size = 60;
      #     dots_center = true;
      #     fade_on_empty = false;
      #     outline_thickness = 4;
      #     font_color = "rgba(${base07-hex}90)";
      #     inner_color = "rgba(${base00-hex}90)";
      #     outer_color = "rgba(${base0D-hex}90)";
      #     check_color = "rgba(${base0E-hex}90)";
      #     placeholder_text = "Enter password...";
      #     shadow_passes = 0;
      #   }
      # ];
    };
  };
}
