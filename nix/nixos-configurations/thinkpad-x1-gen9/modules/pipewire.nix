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
        "wireplumber.settings" = {
          "bluetooth.autoswitch-to-headset-profile" = false;
        };

        "monitor.bluez.properties" = {
          "bluez5.enable-hw-volume" = false;
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = true;
          "bluez5.roles" = [ "a2dp_sink" "a2dp_source" ];
        };
      };
    };
  };

  nixpkgs.config.pulseaudio = true;
  hardware.pulseaudio.enable = false;
  programs.noisetorch.enable = false;
}
