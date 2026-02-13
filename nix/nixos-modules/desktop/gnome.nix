{
  pkgs,
  config,
  lib,
  ...
}: {
  services = {
    gnome = {
      gnome-browser-connector.enable = config.services.desktopManager.gnome.enable;
    };

    desktopManager.cosmic.enable = false;
    desktopManager.gnome.enable = false;
    displayManager.cosmic-greeter.enable = false;
    displayManager.gdm.enable = config.services.desktopManager.gnome.enable;

    xserver = {
      enable = false;
    };

    libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        disableWhileTyping = true;
      };
    };
  };

  # TODO: move it out
  xdg = {
    icons.enable = true;
    portal.enable = true;
  };

  environment = lib.mkIf config.services.desktopManager.gnome.enable {
    pathsToLink = ["/share/xdg-desktop-portal" "/share/applications"];

    systemPackages = with pkgs.gnomeExtensions; [
      tiling-shell
      clipboard-history
      hot-edge
      mouse-follows-focus
      quick-lang-switch
      caffeine
      smile-complementary-extension
      quick-settings-tweaker
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
