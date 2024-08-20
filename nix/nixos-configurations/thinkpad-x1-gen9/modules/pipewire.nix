{
  pkgs,
  lib,
  config,
  ...
}: {
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = false;

    wireplumber.extraConfig = {
        # "10-disable-camera" = {
        #     "wireplumber.profiles" = {
        #       main."monitor.libcamera" = "disabled";
        #     };
        # };

        bluetoothEnhancements = {
            "monitor.bluez.properties" = {
                "bluez5.enable-sbc-xq" = true;
                "bluez5.enable-msbc" = true;
                "bluez5.enable-hw-volume" = true;
            };
        };
    };
  };

  nixpkgs.config.pulseaudio = true;
  hardware.pulseaudio.enable = false;
  programs.noisetorch.enable = false;
}
