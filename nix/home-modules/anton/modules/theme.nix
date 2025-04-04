{
  pkgs,
  lib,
  ...
}: {
  xfconf.enable = lib.mkForce false;

  gtk = {
    enable = true;

    gtk2.extraConfig = ''
      gtk-font-name = "Inter 30";
      font_name = "Inter 30";
      gtk-cursor-theme-size = 64;
    '';
  };

  qt = {
    enable = true;
  };
}
