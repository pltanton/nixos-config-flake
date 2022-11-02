{ pkgs, lib, config, ... }: {
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = false;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;

    config.pipewire = {
      "context.properties" = {
        #"link.max-buffers" = 64;
        "link.max-buffers" =
          16; # version < 3 clients can't handle more than this
        "log.level" = 2; # https://docs.pipewire.org/#Logging
        #"default.clock.rate" = 48000;
        #"default.clock.quantum" = 1024;
        #"default.clock.min-quantum" = 32;
        #"default.clock.max-quantum" = 8192;
      };

    };

    config.pipewire-pulse = {
      "context.exec" = [{
        path = "${pkgs.pulseaudio}/bin/pactl";
        args =
          "load-module module-combine-sink slaves=bluez_output.00_1B_66_B1_06_16.a2dp-sink,alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp__sink sink_name=Headphones";
      }];
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
        {
          name = "libpipewire-module-filter-chain";
          args = {
            "node.description" = "Noise Canceling source";
            "media.name" = "Noise Canceling source";
            "filter.graph" = {
              nodes = [{
                type = "ladspa";
                name = "rnnoise";
                plugin =
                  "${pkgs.rnnoise-plugin}/lib/ladspa/librnnoise_ladspa.so";
                label = "noise_suppressor_mono";
                # control = {
                #   "VAD Threshold (%)" = 50.0;
                #   "VAD Grace Period (ms)" = 200;
                #   "Retroactive VAD Grace (ms)" = 0;
                # };
              }];
            };
            "capture.props" = {
              "node.name" = "capture.rnnoise_source";
              "node.passive" = true;
              "audio.rate" = 48000;
            };
            "playback.props" = {
              "node.name" = "rnnoise_source";
              "media.class" = "Audio/Source";
              "audio.rate" = 48000;
            };
          };
        }

        {
          name = "libpipewire-module-echo-cancel";
          args = {
            # "aec.method" = "webrtc";
            # "node.latency" = "1024/48000";
            "source.props" = {
              "node.name" = "Echo Cancellation Mic";
              # "node.passive" = false;
              # "node.pause-on-idle" = false;
            };
            "sink.props" = {
              "node.name" = "Echo Cancellation Output";
              # "node.passive" = false;
              # "node.pause-on-idle" = false;
            };
          };
        }
      ];
    };

    media-session.config.alsa-monitor = {
      rules = [{
        matches = [{ "node.name" = "~alsa_output.*"; }];
        actions = {
          update-props = {
            "audio.format" = "S16LE";
            # "audio.rate" =
            #   96000; # for USB soundcards it should be twice your desired rate
            # "api.alsa.period-size" =
            #   16; # defaults to 1024, tweak by trial-and-error
            #"api.alsa.disable-batch" = true; # generally, USB soundcards use the batch mode

            "api.alsa.use-acp" = false;
          };
        };
      }];
    };

    media-session.config.bluez-monitor.rules = [
      {
        # Matches all cards
        matches = [{ "device.name" = "~bluez_card.*"; }];
        actions = {
          "update-props" = {
            "bluez5.reconnect-profiles" = [ "hfp_hf" "hsp_hs" "a2dp_sink" ];
            # mSBC is not expected to work on all headset + adapter combinations.
            "bluez5.msbc-support" = true;
            # SBC-XQ is not expected to work on all headset + adapter combinations.
            "bluez5.sbc-xq-support" = true;
            "bluez5.autoswitch-profile" = true;
          };
        };
      }
      {
        matches = [
          # Matches all sources
          {
            "node.name" = "~bluez_input.*";
          }
          # Matches all outputs
          { "node.name" = "~bluez_output.*"; }
        ];
        actions = { "node.pause-on-idle" = false; };
      }
    ];

  };

  nixpkgs.config.pulseaudio = true;
  hardware.pulseaudio.enable = false;
}
