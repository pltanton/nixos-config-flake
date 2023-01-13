{ pkgs, lib, config, ... }: {
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = false;

    config.pipewire = {
      "context.properties" = {
        "link.max-buffers" =
          16; # version < 3 clients can't handle more than this
        "log.level" = 2; # https://docs.pipewire.org/#Logging
      };

    };

    config.pipewire-pulse = {
      "context.properties" = { "monitor.channel-volumes" = "true"; };
      "context.modules" = [
        {
          "name" = "libpipewire-module-rtkit";
          "args" = { };
          "flags" = [ "ifexists" "nofail" ];
        }
        { "name" = "libpipewire-module-protocol-native"; }
        { "name" = "libpipewire-module-client-node"; }
        { "name" = "libpipewire-module-adapter"; }
        { "name" = "libpipewire-module-metadata"; }
        {
          "name" = "libpipewire-module-protocol-pulse";
          "args" = {
            "server.address" = [ "unix:native" ];
            "vm.overrides" = { "pulse.min.quantum" = "1024/48000"; };
          };
        }

        # {
        #   name = "libpipewire-module-filter-chain";
        #   args = {
        #     "node.description" = "Noise Canceling source";
        #     "media.name" = "Noise Canceling source";
        #     "filter.graph" = {
        #       nodes = [{
        #         type = "ladspa";
        #         name = "rnnoise";
        #         plugin =
        #           "${pkgs.rnnoise-plugin}/lib/ladspa/librnnoise_ladspa.so";
        #         label = "noise_suppressor_mono";
        #         # control = {
        #         #   "VAD Threshold (%)" = 50.0;
        #         #   "VAD Grace Period (ms)" = 200;
        #         #   "Retroactive VAD Grace (ms)" = 0;
        #         # };
        #       }];
        #     };
        #     "capture.props" = {
        #       "node.name" = "capture.rnnoise_source";
        #       "node.passive" = true;
        #       "audio.rate" = 48000;
        #     };
        #     "playback.props" = {
        #       "node.name" = "rnnoise_source";
        #       "media.class" = "Audio/Source";
        #       "audio.rate" = 48000;
        #     };
        #   };
        # }

        # {
        #   name = "libpipewire-module-echo-cancel";
        #   args = {
        #     # "aec.method" = "webrtc";
        #     # "node.latency" = "1024/48000";
        #     "source.props" = {
        #       "node.name" = "Echo Cancellation Mic";
        #       # "node.passive" = false;
        #       # "node.pause-on-idle" = false;
        #     };
        #     "sink.props" = {
        #       "node.name" = "Echo Cancellation Output";
        #       # "node.passive" = false;
        #       # "node.pause-on-idle" = false;
        #     };
        #   };
        # }

      ];
    };

    media-session.config.alsa-monitor = {
      rules = [{
        matches = [{ "node.name" = "~alsa_output.*"; }];
        actions = {
          update-props = {
            "audio.format" = "S16LE";
            "monitor.channel-volumes" = "true";
            "api.alsa.use-acp" = false;
          };
        };
      }];
    };
  };

  nixpkgs.config.pulseaudio = true;
  hardware.pulseaudio.enable = false;
  environment.etc = {
    "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
      bluez_monitor.properties = {
        ["bluez5.enable-sbc-xq"] = true,
        ["bluez5.enable-msbc"] = true,
        ["bluez5.enable-hw-volume"] = true,
        ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]",
        ["bluez5.codecs"] = "[ sbc sbc_xq aac aptx aptx_hd aptx_ll ]",
        ["bluez5.auto-connect"] = "[ hfp_hf hsp_hs a2dp_sink ]"
      }
    '';
  };
}
