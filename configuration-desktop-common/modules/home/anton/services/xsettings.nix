{ config, lib, pkgs, ... }:

{
  services.xsettingsd = {
    enable = true;
    settings = {
      "Gdk/UnscaledDPI" = "166912";
      "Xft/DPI" = "166912";
      "ubuntu.user-interface/scale-factor" = 2;
      "org.gnome.desktop.interface/scaling-factor" = 2;
    };
  };
}
