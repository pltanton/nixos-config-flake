{...}: {
  services.blueman.enable = true;

  hardware = {
    bluetooth = {
      enable = true;
      settings = {
        "General" = {
          "AutoConnect" = true;
          "Enable" = "Source,Sink,Media,Control,Gateway,Socket,Headset";
          "MultiProfile" = "multiple";
          "AutoEnable" = true;
        };
      };
      # hsphfpd.enable = true;
      # disabledPlugins = [ "sap" ];
    };
  };
}
