{
  config,
  lib,
  pkgs,
  ...
}: {
  services.dunst = {
    enable = false;
    settings = with config.lib.stylix.colors; {
      global = {
        width = 500;
        offset = "10x10";
        origin = "top-center";
        alignment = "center";
        follow = "mouse";
        frame_width = 0;
        separator_height = 0;
        sort = true;
      };
    };

    iconTheme = {
      inherit (config.gtk.iconTheme) name;
      inherit (config.gtk.iconTheme) package;
      size = "128x128";
    };
  };
}
