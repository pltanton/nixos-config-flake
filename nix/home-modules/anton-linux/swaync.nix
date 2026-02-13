{lib, ...}: {
  services.swaync = {
    enable = false;
    # settings = {
    #   positionX = "right";
    #   positionY = "top";
    #   layer = "overlay";
    #   control-center-layer = "top";
    #   layer-shell = true;
    #   notification-2fa-action = true;
    #   notification-inline-replies = false;
    #   notification-icon-size = 64;
    #   notification-body-image-height = 60;
    #   notification-body-image-width = 100;
    #
    #   control-center-margin-top = 15;
    #   control-center-margin-bottom = 15;
    #   control-center-margin-left = 15;
    #   control-center-margin-right = 15;
    #
    #   widgets = [
    #     "title"
    #     "mpris"
    #     "notifications"
    #   ];
    #   widget-config = {
    #     title = {
    #       text = "Notifications";
    #       clear-all-button = true;
    #       button-text = "Clear All";
    #     };
    #     mpris = {
    #       image-size = 96;
    #       image-radius = 12;
    #       blur = true;
    #     };
    #   };
    # };
  };
}
