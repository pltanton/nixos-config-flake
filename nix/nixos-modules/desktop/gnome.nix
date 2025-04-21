{
  pkgs,
  config,
  lib,
  ...
}: {
  services = {
    gnome = {
      gnome-browser-connector.enable = true;
    };

    xserver = {
      enable = false;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    libinput = {
      enable = true;
      touchpad = {tapping = true;};
    };
  };

  # TODO: move it out
  xdg = {
    icons.enable = true;
    portal.enable = true;
  };

  environment = lib.mkIf config.service.xserver.gnome.enable {
    pathsToLink = ["/share/xdg-desktop-portal" "/share/applications"];

    systemPackages = with pkgs.gnomeExtensions; [
      tiling-shell
      clipboard-history
      cloudflare-warp-toggle
      hot-edge
      mouse-follows-focus
      quick-lang-switch
      caffeine
      smile-complementary-extension
      pkgs.smile
    ];

    gnome.excludePackages = with pkgs; [
      atomix # puzzle game
      cheese # webcam tool
      epiphany # web browser
      evince # document viewer
      geary # email reader
      gedit # text editor
      gnome-terminal
      gnome-tour
      hitori # sudoku game
      iagno # go game
      tali # poker game
    ];
  };
}
