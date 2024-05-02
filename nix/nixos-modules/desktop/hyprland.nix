{
  pkgs,
  config,
  ...
}: {
  programs.hyprland = {
    enable = true;
  };

  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [
  #     pkgs.xdg-desktop-portal-gtk
  #   ];
  # configPackages = [
  #   config.programs.hyprland.portalPackage
  # ];
  # config = {
  #   preferred = {
  #     default = "gtk;hyprland";
  #   };
  # };
  # };
}
