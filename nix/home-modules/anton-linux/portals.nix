{pkgs, ...}: {
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];

    xdgOpenUsePortal = true;

    # config = {
    #   hyprland = {
    #     default = [
    #       "hyprland"
    #       "gtk"
    #     ];
    #   };
    # };
  };
}
