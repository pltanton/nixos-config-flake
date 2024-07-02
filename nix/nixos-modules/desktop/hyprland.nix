{
  pkgs,
  inputs,
  ...
}: {
  programs.hyprland = {
    enable = true;
  };

  xdg.portal = {
    enable = true;
    # xdgOpenUsePortal = true;
    # extraPortals = [
    #   pkgs.xdg-desktop-portal-gtk
    #   pkgs.xdg-desktop-portal-hyprland
    # ];

    # configPackages = [
    #   config.programs.hyprland.portalPackage
    # ];
  };
}
