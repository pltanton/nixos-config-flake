_: {
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = false;

    pulse.enable = true;
    extraConfig.pipewire-pulse = {
      # "10-tune" = {
      #   "stream.propertiesa" = {
      #     "resample.quality" = 10;
      #   };
      # };

      "60-echo-cancel" = {
        "context.modules" = [
          {
            name = "libpipewire-module-echo-cancel";
            args = {
              "monitor.mode" = true;
              "source.props" = {
                "node.name" = "source_ec";
                "node.description" = "Echo-cancelled source";
              };
              "aec.args" = {
                "webrtc.gain_control" = true;
                "webrtc.extended_filter" = false;
                #webrtc.analog_gain_control = false
                #webrtc.digital_gain_control = true
                #webrtc.experimental_agc = true
                "webrtc.noise_suppression" = true;
              };
            };
          }
        ];
      };
    };

    wireplumber.enable = true;
    wireplumber.extraConfig = {
      "10-disable-camera" = {
        "wireplumber.profiles" = {
          main."monitor.libcamera" = "disabled";
        };
      };

      # "10-device-profile-priority" = {
      #   "wireplumber.settings" = {
      #     "device.restore-profile" = true;
      #   };

      #   "device.profile.priority.rules" = [
      #     {
      #       matches = [
      #         {
      #           "device.name" = "alsa_card.pci-0000_00_1f.3-platform-skl_hda_dsp_generic";
      #         }
      #       ];
      #       actions = {
      #         update-props = {
      #           priorities = [
      #             "HiFi (HDMI1, HDMI2, HDMI3, Mic1, Mic2, Speaker)"
      #             "HiFi (HDMI1, HDMI2, HDMI3, Headphones, Mic1, Mic2)"
      #             "pro-audio"
      #           ];
      #         };
      #       };
      #     }
      #   ];
      # };

      # "10-disable-hdmi-audio" = {
      #   "monitor.alsa.rules" = [
      #     {
      #       "matches" = [
      #         {"node.name" = "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__HDMI1__sink";}
      #       ];
      #       "actions" = {
      #         "update-props" = {
      #           "node.disabled" = true;
      #           # "priority.session" = 1;
      #           # "priority.driver" = 1;
      #         };
      #       };
      #     }
      #   ];
      # };

      "11-bluez" = {
        "wireplumber.settings" = {
          "bluetooth.autoswitch-to-headset-profile" = false;
        };

        # "monitor.bluez.properties" = {
        #   "bluez5.enable-hw-volume" = false;
        #   "bluez5.enable-sbc-xq" = true;
        #   "bluez5.enable-msbc" = true;
        #   "bluez5.roles" = [ "a2dp_sink" "a2dp_source" ];
        # };
      };

      "12-fix-stutterings" = {
        "monitor.alsa.rules" = [
          {
            "matches" = [
              {"node.name" = "~alsa_output.*";}
            ];
            "actions" = {
              "update-props" = {
                "api.alsa.period-size" = 1024;
                "api.alsa.headroom" = 8192;
                "session.suspend-timeout-seconds" = 0;
              };
            };
          }
        ];
      };
    };
  };

  nixpkgs.config.pulseaudio = true;
  hardware.pulseaudio.enable = false;
  programs.noisetorch.enable = false;
}
