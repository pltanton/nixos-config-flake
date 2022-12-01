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
