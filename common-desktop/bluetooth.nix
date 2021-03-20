{ pkgs, ... }: {
  services.blueman.enable = true;

  hardware = {
    bluetooth = {
      settings = {
        "General" = {
          "AutoConnect" = true;
          "Enable" = "Source,Sink,Media,Socket";
        };
      };
    };

    bluetooth.enable = true;
  };
}
