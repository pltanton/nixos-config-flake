{ pkgs, ... }: {
  security.rtkit.enable = false;

  programs.noisetorch.enable = false;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    media-session.enable = true;

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
            "server.address" = [ "unix=native" ];
            "vm.overrides" = { "pulse.min.quantum" = "1024/48000"; };
          };
        }
        {
          name = "libpipewire-module-echo-cancel";
          args = {
            # "aec.method" = "webrtc";
            # # node.latency = 1024/48000
            # "source.props" = { "node.name" = "Echo Cancellation Source"; };
            # "sink.props" = { "node.name" = "Echo Cancellation Sink"; };
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
  services.ofono.enable = false;
  hardware = {
    pulseaudio.enable = false;
    pulseaudio.support32Bit = true;
    pulseaudio.package = pkgs.pulseaudioFull;
    pulseaudio.extraConfig = ''
      load-module module-alsa-sink device=hw=0,3
      load-module module-bluetooth-policy auto_switch=2

      load-module module-echo-cancel aec_method=webrtc source_name=echoCancel_source sink_name=echoCancel_sink
      set-default-source echoCancel_source
      set-default-sink echoCancel_sink
    '';
    # pulseaudio.extraConfig = ''
    #   load-module module-alsa-sink device=hw=0,7
    #   load-module module-bluetooth-policy auto_switch=2
    # '';

    pulseaudio.extraModules = [ pkgs.pulseaudio-modules-bt ];

    pulseaudio.tcp.anonymousClients.allowedIpRanges =
      [ "127.0.0.1" "192.168.0.0/16" ];
    pulseaudio.tcp.enable = true;
    pulseaudio.zeroconf.publish.enable = true;
  };
}