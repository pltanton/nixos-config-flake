{ pkgs, config, ... }: {
  services.dunst = {
    enable = true;

    settings = with config.lib.base16.theme; {
      global = {
        font = "${fontConsoleName} ${fontConsoleSize}";
        markup = "yes";
        format = "%b";
        sort = "yes";
        indicate_hidden = "yes";
        alignment = "left";
        bounce_freq = 0;
        show_age_threshold = 60;
        word_wrap = "yes";
        ignore_newline = "no";
        geometry = "500x60-65+65";
        shrink = "no";
        transparency = 18;
        idle_threshold = 120;
        monitor = 0;
        follow = "mouse";
        sticky_history = "yes";
        history_length = "20";
        show_indicators = "yes";
        line_height = 0;
        separator_height = 1;
        padding = 8;
        horizontal_padding = 8;
        separator_color = "frame";
        icon_position = "left";
        frame_width = 0;
      };
      urgency_low = {
        background = "#${base01-hex}";
        foreground = "#${base03-hex}";
      };
      urgency_normal = {
        background = "#${base02-hex}";
        foreground = "#${base05-hex}";
      };
      urgency_critical = {
        msg_urgency = "CRITICAL";
        background = "#${base08-hex}";
        foreground = "#${base06-hex}";
      };

    };
  };
}
