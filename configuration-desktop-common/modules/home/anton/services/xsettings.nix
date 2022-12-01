{ config, lib, pkgs, ... }:

{
  services.xsettingsd = {
    enable = true;
    settings = {
      "Gdk/UnscaledDPI" = "166912";
      "Xft/DPI" = "166912";
    };
  };
}
