{pkgs, ...}: {
  xdg.portal = {
    enable = false;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];

    xdgOpenUsePortal = true;

    config = {
      hyprland = {
        default = [
          "gtk"
          "hyprland"
        ];
      };
    };
  };
}
