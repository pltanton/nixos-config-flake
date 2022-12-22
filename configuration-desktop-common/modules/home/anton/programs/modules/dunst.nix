{ osConfig, config, lib, pkgs, ... }:

{
  services.dunst = {
    enable = true;
    settings = with osConfig.lib.stylix.colors; {
      global = {
        width = 500;
        offset = "10x10";
        alignment = "right";
        # TODO Replace it with stylix or custom module
        frame_width = 0;
        separator_height = 0;
        sort = true;
      };
    };

    iconTheme = {
      name = config.gtk.iconTheme.name;
      package = config.gtk.iconTheme.package;
      size = "128x128";
    };
  };
}
