{ pkgs, ... }:
{
  services.blueman.enable = true;

  hardware = {
    bluetooth = {
      config = {
        "General" = {
          "AutoConnect" = true;
          "Enable" = "Source,Sink,Media,Socket";
        };
      };
    };

    bluetooth.enable = true;
  };
}
