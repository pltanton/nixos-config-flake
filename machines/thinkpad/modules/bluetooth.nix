{ pkgs, ... }:
{
  services.blueman.enable = true;

  hardware = {
    bluetooth = {
      config = {
        "General" = {
          "AutoConnect" = true;
          "Enable" = "Source,Sink,Media,Control,Gateway,Socket,Headset";
          "MultiProfile" = "multiple";
        };
      };
    };

    bluetooth.enable = true;
  };
}
