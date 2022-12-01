{ config, lib, pkgs, ... }:

{
  services.dunst = {
    enable = true;
    settings = with config.lib.base16.theme; {
      global = {
        width = 500;
        offset = "10x10";
        alignment = "right";
        font = "${fontUIName} ${fontUISize}";
        frame_width = 0;
        separator_height = 0;
        sort = true;
      };
      urgency_low = {
        background = "#${base01-hex}C8";
        foreground = "#${base03-hex}";
      };
      urgency_normal = {
        background = "#${base01-hex}C8";
        foreground = "#${base05-hex}";
      };
      urgency_critical = {
        msg_urgency = "CRITICAL";
        background = "#${base01-hex}C8";
        foreground = "#${base08-hex}";
      };
    };

    iconTheme = {
      name = config.lib.base16.theme.iconTheme;
      package = config.lib.base16.theme.iconPackage;
      size = "128x128";
    };
  };
}
