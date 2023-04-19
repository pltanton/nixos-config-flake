{ config, lib, pkgs, ... }:

{
  services.xsettingsd = {
    enable = true;
    settings = {
      "Gdk/UnscaledDPI" = "199680";
      "Xft/DPI" = "199680";
    };
  };
}
